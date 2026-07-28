# Agent Instructions

## FHIR Parent Baseline During Development

When developing changes that alter content published in a FHIR package or IG,
first resolve every directly declared, Cognovis-managed parent dependency to its
newest stable published version. Update the repository's authored dependency
source of truth, regenerate derived dependency declarations or locks according
to the repository instructions, and run the repository's supported local build
and test steps for the affected output against that baseline.

This is a development responsibility. It does not mean that unchanged published
children are invalid when a newer parent exists: their declared pins remain
minimum supported versions.

Do not implement this instruction as a CI check, pre-push hook, release gate,
automatic re-pin, background synchronization, or cascade. Repository-only
documentation, workflow, release metadata, and other control changes that do
not alter published package or IG output do not require a dependency refresh.
The dependency edits that establish the baseline are part of the same
development step and do not recursively trigger another refresh or cascade.
