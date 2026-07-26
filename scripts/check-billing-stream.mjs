import { readFileSync } from "node:fs";
import { join } from "node:path";

const root = process.cwd();

function readResource(fileName) {
  return JSON.parse(
    readFileSync(join(root, "fsh-generated", "resources", fileName), "utf8"),
  );
}

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

function extensions(resource, url) {
  return (resource.extension ?? []).filter((extension) => extension.url === url);
}

function nested(extension, url) {
  return (extension.extension ?? []).find((child) => child.url === url);
}

function careType(item) {
  return (item.extension ?? []).find(
    (extension) =>
      extension.url ===
      "https://fhir.cognovis.de/dental/StructureDefinition/ze-versorgungsart",
  )?.valueCode;
}

function billingSystems(claim) {
  return new Set(
    (claim.item ?? []).flatMap((item) =>
      (item.productOrService?.coding ?? []).map((coding) => coding.system),
    ),
  );
}

function satisfiesEqualTypeMix(claim) {
  const equalTypeExists = (claim.item ?? []).some(
    (item) => careType(item) === "gleichartig",
  );
  if (!equalTypeExists) {
    return true;
  }
  const systems = billingSystems(claim);
  return (
    systems.has("http://fhir.de/CodeSystem/kzbv/bema") &&
    systems.has("http://fhir.de/CodeSystem/bzaek/goz")
  );
}

function satisfiesGozAgreement(chargeItem) {
  const factor = chargeItem.factorOverride;
  const requestedService = extensions(
    chargeItem,
    "https://fhir.cognovis.de/dental/StructureDefinition/verlangensleistung",
  ).some(
    (extension) =>
      nested(extension, "verlangensleistung")?.valueBoolean === true,
  );
  if (factor === undefined || factor <= 3.5 || requestedService) {
    return true;
  }
  return (
    extensions(
      chargeItem,
      "https://fhir.cognovis.de/dental/StructureDefinition/goz-honorarvereinbarung",
    ).length > 0
  );
}

const carePlanProfile = readResource(
  "StructureDefinition-dental-care-plan.json",
);
const intentElements = [
  ...(carePlanProfile.differential?.element ?? []),
  ...(carePlanProfile.snapshot?.element ?? []),
].filter((element) => element.path === "CarePlan.intent");
assert(
  intentElements.every(
    (element) =>
      element.fixedCode === undefined && element.patternCode === undefined,
  ),
  "DentalCarePlanDE still fixes CarePlan.intent",
);
assert(
  readResource("CarePlan-ExampleHkpCarePlan.json").intent === "plan",
  "The selected HKP example is not a plan",
);
assert(
  readResource("CarePlan-ExampleHkpCarePlanOption.json").intent === "option",
  "The alternative HKP example is not an option",
);

const amount2025 = readResource("Claim-ExampleFestzuschussAmount2025.json");
const amount2026 = readResource("Claim-ExampleFestzuschussAmount2026.json");
const amountUrl =
  "https://fhir.cognovis.de/dental/StructureDefinition/festzuschuss-betrag";
const amountExtensions = [amount2025, amount2026].map((claim) =>
  (claim.item[0].extension ?? []).find(
    (extension) => extension.url === amountUrl,
  ),
);
for (const amountExtension of amountExtensions) {
  assert(amountExtension, "A versioned amount fixture has no amount extension");
  assert(
    nested(amountExtension, "amount")?.valueMoney?.currency === "EUR",
    "A versioned amount fixture is not denominated in EUR",
  );
  const period = nested(amountExtension, "effectivePeriod")?.valuePeriod;
  assert(
    period?.start && period?.end && period.start < period.end,
    "A versioned amount fixture has no ordered closed period",
  );
  assert(
    nested(amountExtension, "source")?.valueUri?.startsWith(
      "https://example.org/",
    ),
    "A public amount fixture is not marked with synthetic provenance",
  );
}
assert(
  nested(amountExtensions[0], "amount").valueMoney.value !==
    nested(amountExtensions[1], "amount").valueMoney.value,
  "The two amount periods do not demonstrate versioned values",
);

const gozProfile = readResource("StructureDefinition-goz-charge-item.json");
const gozConstraints = (gozProfile.differential?.element ?? [])
  .flatMap((element) => element.constraint ?? [])
  .map((constraint) => constraint.key);
assert(
  gozConstraints.includes("goz-factor-agreement") &&
    gozConstraints.includes("goz-agreement-before-service"),
  "The GOZ agreement constraints are missing from the profile",
);
const agreedCharge = readResource(
  "ChargeItem-ExampleGozChargeItemWithAgreement.json",
);
assert(satisfiesGozAgreement(agreedCharge), "The valid GOZ agreement fails");
const missingAgreement = structuredClone(agreedCharge);
missingAgreement.extension = (missingAgreement.extension ?? []).filter(
  (extension) =>
    extension.url !==
    "https://fhir.cognovis.de/dental/StructureDefinition/goz-honorarvereinbarung",
);
assert(
  !satisfiesGozAgreement(missingAgreement),
  "Factor 4.5 without an agreement was accepted",
);
const boundaryCharge = structuredClone(missingAgreement);
boundaryCharge.factorOverride = 3.5;
assert(
  satisfiesGozAgreement(boundaryCharge),
  "The factor 3.5 boundary incorrectly requires an agreement",
);

const mixedClaim = readResource("Claim-ExampleDentalClaimMixed.json");
assert(
  satisfiesEqualTypeMix(mixedClaim),
  "The complete mixed claim does not satisfy the equal-type rule",
);
const supportingSequences = new Set(
  (mixedClaim.supportingInfo ?? []).map((info) => info.sequence),
);
assert(
  (mixedClaim.item ?? []).every((item) =>
    (item.informationSequence ?? []).every((sequence) =>
      supportingSequences.has(sequence),
    ),
  ),
  "A mixed claim line points to a missing supportingInfo sequence",
);
const missingBema = structuredClone(mixedClaim);
missingBema.item = missingBema.item.filter(
  (item) =>
    !item.productOrService.coding.some(
      (coding) => coding.system === "http://fhir.de/CodeSystem/kzbv/bema",
    ),
);
assert(
  !satisfiesEqualTypeMix(missingBema),
  "An equal-type GOZ-only claim was accepted",
);
const otherTypeOnly = structuredClone(missingBema);
for (const item of otherTypeOnly.item) {
  for (const extension of item.extension ?? []) {
    if (
      extension.url ===
      "https://fhir.cognovis.de/dental/StructureDefinition/ze-versorgungsart"
    ) {
      extension.valueCode = "andersartig";
    }
  }
}
assert(
  satisfiesEqualTypeMix(otherTypeOnly),
  "A GOZ-only other-type claim incorrectly requires a BEMA line",
);

console.log("Billing stream fixture checks passed");
