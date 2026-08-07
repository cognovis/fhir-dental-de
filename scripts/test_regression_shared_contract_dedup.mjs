#!/usr/bin/env node

import assert from "node:assert/strict";
import { existsSync, readFileSync, readdirSync, statSync } from "node:fs";
import { dirname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const repositoryRoot = process.env.REPOSITORY_ROOT
  ? resolve(process.env.REPOSITORY_ROOT)
  : resolve(dirname(fileURLToPath(import.meta.url)), "..");

function read(relativePath) {
  return readFileSync(join(repositoryRoot, relativePath), "utf8");
}

function sourceFiles(relativePath) {
  const root = join(repositoryRoot, relativePath);
  const files = [];
  for (const entry of readdirSync(root)) {
    const absolutePath = join(root, entry);
    if (statSync(absolutePath).isDirectory()) {
      files.push(...sourceFiles(relative(repositoryRoot, absolutePath)));
    } else {
      files.push(absolutePath);
    }
  }
  return files;
}

// Guards against reintroducing IG-local definitions for shared terminology.
const retiredDefinitions = [
  "input/fsh/codesystems/GozCS.fsh",
  "input/fsh/codesystems/ToothSurfacesCS.fsh",
];
for (const relativePath of retiredDefinitions) {
  assert.equal(existsSync(join(repositoryRoot, relativePath)), false, relativePath);
}

const activeSources = [
  ...sourceFiles("input"),
  ...sourceFiles("test"),
  join(repositoryRoot, "sushi-config.yaml"),
];
const activeText = activeSources
  .map((file) => readFileSync(file, "utf8"))
  .join("\n");
const retiredDentalCanonical =
  "https://fhir.cognovis.de/dental/CodeSystem/tooth-surfaces";
assert.doesNotMatch(activeText, new RegExp(retiredDentalCanonical));
assert.doesNotMatch(activeText, /\b(?:GozCS|ToothSurfacesCS)\b/);
assert.doesNotMatch(activeText, /\$fdi(?:CS|-tooth)#[0-9]+\s+"Zahn [0-9]+"/);

const expectedParents = new Map([
  ["input/fsh/profiles/DentalEncounterDE.fsh", "Parent: EncounterPraxis"],
  ["input/fsh/profiles/DentalCommunicationDE.fsh", "Parent: PraxisCommunication"],
  [
    "input/fsh/profiles/DentalPractitionerRoleDE.fsh",
    "Parent: PraxisPractitionerRoleDE",
  ],
]);
for (const [relativePath, parent] of expectedParents) {
  assert.match(read(relativePath), new RegExp(`^${parent}$`, "m"), relativePath);
}

const interoperability = read("input/pagecontent/international-interoperability.md");
assert.match(interoperability, /48 profiles, 46 extensions/);
assert.match(interoperability, /RC1 has no `mz-TreatmentObjective` profile/);
assert.doesNotMatch(interoperability, /28 profiles|43 extensions|nl-core-TreatmentObjective/);

const generatedExpectations = new Map([
  [
    "dental-encounter",
    "https://fhir.cognovis.de/praxis/StructureDefinition/encounter-praxis",
  ],
  [
    "dental-communication",
    "https://fhir.cognovis.de/praxis/StructureDefinition/praxis-communication",
  ],
  [
    "dental-practitioner-role",
    "https://fhir.cognovis.de/praxis/StructureDefinition/praxis-practitioner-role-de",
  ],
]);
for (const [id, baseDefinition] of generatedExpectations) {
  const generatedPath = join(
    repositoryRoot,
    "fsh-generated",
    "resources",
    `StructureDefinition-${id}.json`,
  );
  if (existsSync(generatedPath)) {
    const generated = JSON.parse(readFileSync(generatedPath, "utf8"));
    assert.equal(generated.baseDefinition, baseDefinition, id);
  }
}

console.log("Shared-contract deduplication regression checks passed.");
