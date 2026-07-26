import {
  readFileSync,
  readdirSync,
  statSync,
} from "node:fs";
import { extname, join, relative, resolve } from "node:path";

const repositoryRoot = process.cwd();
const invalidCodes = [
  ["32884", "-9"].join(""),
  ["95570", "007"].join(""),
  ["K05", ".31"].join(""),
];
const invalidDisplays = [
  "Periodontal pocket depth [Length] Mouth by Periodontal probing",
  '"display": "Probing depth"',
];
const activeExtensions = new Set([".fsh", ".http", ".md", ".json"]);

function assert(condition, message) {
  if (!condition) {
    throw new Error(message);
  }
}

function collectFiles(path) {
  if (!statSync(path).isDirectory()) {
    return [path];
  }
  return readdirSync(path, { withFileTypes: true }).flatMap((entry) => {
    const entryPath = join(path, entry.name);
    if (entry.isDirectory()) {
      return collectFiles(entryPath);
    }
    return activeExtensions.has(extname(entry.name)) ? [entryPath] : [];
  });
}

function scan(paths) {
  const violations = paths.flatMap((path) =>
    collectFiles(path).flatMap((file) => {
      const content = readFileSync(file, "utf8");
      return [...invalidCodes, ...invalidDisplays]
        .filter((fragment) => content.includes(fragment))
        .map(
          (fragment) =>
            `${relative(repositoryRoot, file)} contains ${fragment}`,
        );
    }),
  );
  assert(
    violations.length === 0,
    `Invalid periodontal terminology:\n${violations.join("\n")}`,
  );
}

const scanOnlyIndex = process.argv.indexOf("--scan-only");
if (scanOnlyIndex !== -1) {
  const target = process.argv[scanOnlyIndex + 1];
  assert(target, "--scan-only requires a file or directory");
  scan([resolve(target)]);
  console.log("Periodontal terminology scan passed");
  process.exit(0);
}

scan([
  join(repositoryRoot, "input"),
  join(repositoryRoot, "test"),
]);

const requiredFragments = new Map([
  [
    "input/fsh/profiles/PeriodontalObservationDE.fsh",
    "http://loinc.org#32910-2",
  ],
  [
    "input/fsh/profiles/RadiographicBoneLossObservationDE.fsh",
    "http://snomed.info/sct#109706009",
  ],
  [
    "input/fsh/valuesets/DentalFindingCodesVS.fsh",
    "* $sct#109706009",
  ],
  [
    "input/fsh/valuesets/PeriodontalFindingCodesVS.fsh",
    '$loinc#32910-2 "Probing depth {Tooth}.{probe site} Measured"',
  ],
  [
    "input/fsh/valuesets/PeriodontalFindingCodesVS.fsh",
    '$sct#109706009 "Alveolar bone loss"',
  ],
  [
    "input/fsh/valuesets/ProphylaxisFindingCodesVS.fsh",
    '$loinc#32953-2 "Plaque index Dentition Calculated"',
  ],
  [
    "input/fsh/valuesets/ProphylaxisFindingCodesVS.fsh",
    '$loinc#32951-6 "Bleeding on probing index Gingiva Calculated"',
  ],
  [
    "input/fsh/examples/ExampleParCarePlan.fsh",
    '$icd10gm#K05.3 "Chronische Parodontitis"',
  ],
  [
    "input/fsh/examples/ExampleDentalImagingStudy.fsh",
    'icd-10-gm#K05.3 "Chronische Parodontitis"',
  ],
]);

for (const [file, fragment] of requiredFragments) {
  assert(
    readFileSync(join(repositoryRoot, file), "utf8").includes(fragment),
    `${file} is missing required terminology: ${fragment}`,
  );
}

console.log("Periodontal terminology checks passed");
