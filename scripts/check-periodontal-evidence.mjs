import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";

const repositoryRoot = process.cwd();
const resourceDirectory = join(
  repositoryRoot,
  "fsh-generated",
  "resources",
);
const gradingExtensionUrl =
  "https://fhir.cognovis.de/dental/StructureDefinition/par-grading-evidence";

function readResource(fileName) {
  return JSON.parse(
    readFileSync(join(resourceDirectory, fileName), "utf8"),
  );
}

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

function readSource(relativePath) {
  return readFileSync(join(repositoryRoot, relativePath), "utf8");
}

const extensionSource = readSource(
  "input/fsh/extensions/ParGradingEvidenceExt.fsh",
);
assert(
  extensionSource.includes("* ^status = #retired"),
  "The duplicate PAR grading evidence extension is not retired in FSH",
);

const conditionSource = readSource(
  "input/fsh/examples/ExampleParCarePlan.fsh",
);
assert(
  !conditionSource.includes(gradingExtensionUrl),
  "The active PAR Condition still uses the retired grading extension in FSH",
);
for (const evidenceRule of [
  "* evidence[0].detail[0] = Reference(ExampleRadiographicBoneLoss)",
  "* evidence[0].detail[1] = Reference(ExampleHbA1cForParGrading)",
  "* evidence[0].detail[2] = Reference(ExampleSmokingStatusForParGrading)",
]) {
  assert(
    conditionSource.includes(evidenceRule),
    `The PAR Condition FSH is missing ${evidenceRule}`,
  );
}

const evidenceSource = readSource(
  "input/fsh/examples/ExampleParGradingEvidence.fsh",
);
assert(
  evidenceSource.includes("InstanceOf: HbA1cObservationDE"),
  "The PAR HbA1c FSH does not reuse HbA1cObservationDE",
);
assert(
  evidenceSource.includes("InstanceOf: SmokingStatusDE"),
  "The PAR smoking FSH does not reuse SmokingStatusDE",
);

const screeningSource = readSource(
  "input/fsh/examples/ExampleOralHealthScreening.fsh",
);
assert(
  screeningSource.includes(
    "derivedFrom[0] = Reference(ExampleSmokingStatusForParGrading)",
  ),
  "The oral-screening FSH is not linked to its source Observation",
);

if (
  process.argv.includes("--source-only") ||
  !existsSync(resourceDirectory)
) {
  console.log("Periodontal evidence source checks passed");
  process.exit(0);
}

const gradingExtension = readResource(
  "StructureDefinition-par-grading-evidence.json",
);
assert(
  gradingExtension.status === "retired",
  "The duplicate PAR grading evidence extension is not retired",
);

const condition = readResource("Condition-ExampleParodontitisCondition.json");
assert(
  !(condition.extension ?? []).some(
    (extension) => extension.url === gradingExtensionUrl,
  ),
  "The active PAR Condition still uses the retired grading extension",
);
const evidenceReferences = new Set(
  (condition.evidence ?? []).flatMap((evidence) =>
    (evidence.detail ?? []).map((detail) => detail.reference),
  ),
);
for (const reference of [
  "Observation/ExampleRadiographicBoneLoss",
  "Observation/ExampleHbA1cForParGrading",
  "Observation/ExampleSmokingStatusForParGrading",
]) {
  assert(
    evidenceReferences.has(reference),
    `The PAR Condition is missing evidence reference ${reference}`,
  );
}

const hba1c = readResource("Observation-ExampleHbA1cForParGrading.json");
assert(
  hba1c.meta?.profile?.includes(
    "https://fhir.cognovis.de/praxis/StructureDefinition/hba1c-observation-de",
  ),
  "The PAR HbA1c example does not reuse HbA1cObservationDE",
);

const smoking = readResource(
  "Observation-ExampleSmokingStatusForParGrading.json",
);
assert(
  smoking.meta?.profile?.includes(
    "https://fhir.cognovis.de/praxis/StructureDefinition/smoking-status-de",
  ),
  "The PAR smoking example does not reuse SmokingStatusDE",
);

const screening = readResource("Observation-ExampleOralHealthScreening.json");
assert(
  (screening.derivedFrom ?? []).some(
    (reference) =>
      reference.reference ===
      "Observation/ExampleSmokingStatusForParGrading",
  ),
  "The oral-screening smoking summary is not linked to its source Observation",
);

console.log("Periodontal evidence checks passed");
