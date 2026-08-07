import { existsSync, readFileSync } from "node:fs";
import { join, resolve } from "node:path";

const repositoryRoot = process.cwd();
const resourceDirectory = process.argv[2]
  ? resolve(repositoryRoot, process.argv[2])
  : join(repositoryRoot, "fsh-generated", "resources");
const codeSystemFileName = "CodeSystem-tooth-identification-fdi.json";
const valueSetFileName = "ValueSet-tooth-identification-fdi.json";
const canonical =
  "https://fhir.cognovis.de/dental/CodeSystem/tooth-identification-fdi";

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

function readGeneratedResource(fileName, description) {
  const path = join(resourceDirectory, fileName);
  assert(
    existsSync(path),
    `Generated FHIR package is missing ${description}: ${fileName}`,
  );
  return JSON.parse(readFileSync(path, "utf8"));
}

function conceptCodes(concepts = []) {
  return concepts.flatMap((concept) => [
    concept.code,
    ...conceptCodes(concept.concept),
  ]);
}

function expectedCodes(quadrants, positions) {
  return quadrants.flatMap((quadrant) =>
    positions.map((position) => `${quadrant}${position}`),
  );
}

function assertSameCodes(actualCodes, expectedCodes, description) {
  const actual = new Set(actualCodes);
  const expected = new Set(expectedCodes);
  const missing = [...expected].filter((code) => !actual.has(code));
  const unexpected = [...actual].filter((code) => !expected.has(code));

  assert(
    actualCodes.length === expectedCodes.length &&
      actual.size === expected.size &&
      missing.length === 0 &&
      unexpected.length === 0,
    `${description} must contain exactly ${expected.size} tooth positions; ` +
      `missing: ${missing.join(", ") || "none"}; ` +
      `unexpected: ${unexpected.join(", ") || "none"}`,
  );
}

const permanentCodes = expectedCodes([1, 2, 3, 4], [1, 2, 3, 4, 5, 6, 7, 8]);
const deciduousCodes = expectedCodes([5, 6, 7, 8], [1, 2, 3, 4, 5]);
const allToothCodes = [...permanentCodes, ...deciduousCodes];

const codeSystem = readGeneratedResource(
  codeSystemFileName,
  "the authoritative Cognovis FDI CodeSystem",
);
assert(
  !existsSync(join(resourceDirectory, "CodeSystem-ex-tooth.json")),
  "The generated FHIR package still contains the conflicting ex-tooth CodeSystem",
);
assert(
  codeSystem.resourceType === "CodeSystem" && codeSystem.url === canonical,
  `Generated ${codeSystemFileName} does not expose ${canonical}`,
);
assert(
  codeSystem.content === "complete",
  "The Cognovis FDI CodeSystem must declare complete content",
);
const codeSystemCodes = conceptCodes(codeSystem.concept);
assertSameCodes(
  codeSystemCodes,
  allToothCodes,
  "The Cognovis FDI CodeSystem",
);

const valueSet = readGeneratedResource(
  valueSetFileName,
  "the FDI tooth-position ValueSet",
);
const includes = valueSet.compose?.include ?? [];
assert(
  valueSet.resourceType === "ValueSet" &&
    valueSet.url ===
      "https://fhir.cognovis.de/dental/ValueSet/tooth-identification-fdi",
  `Generated ${valueSetFileName} has the wrong canonical URL`,
);
assert(
  includes.length === 1 &&
    includes[0].system === canonical &&
    (includes[0].filter ?? []).length === 0 &&
    (valueSet.compose?.exclude ?? []).length === 0,
  "The FDI tooth-position ValueSet must include only the complete Cognovis FDI CodeSystem",
);
const valueSetCodes = (includes[0].concept ?? []).length
  ? includes[0].concept.map((concept) => concept.code)
  : codeSystemCodes;
assertSameCodes(
  valueSetCodes,
  allToothCodes,
  "The FDI tooth-position ValueSet",
);

for (const representative of ["36", "75"]) {
  assert(
    valueSetCodes.includes(representative),
    `The FDI tooth-position ValueSet does not support representative tooth ${representative}`,
  );
}

const extension = readGeneratedResource(
  "StructureDefinition-fdi-tooth-number.json",
  "the FDI tooth-number extension",
);
const extensionValue = (extension.differential?.element ?? []).find(
  (element) => element.path === "Extension.value[x]",
);
assert(
  extensionValue?.type?.length === 1 &&
    extensionValue.type[0].code === "code",
  "FdiToothNumberExt must remain a valueCode extension",
);

console.log("FDI tooth terminology package checks passed");
