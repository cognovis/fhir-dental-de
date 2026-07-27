# Caries and Pulp Sensibility

## ICDAS caries observations

`CariesObservationDE` records one visual coronal caries lesion score for one
tooth. Tooth surfaces are carried on `Observation.bodySite` with the
`ToothSurfacesExt` extension.

The required result uses `ICDASCariesScoreVS`, limited to ICDAS II lesion scores
0 through 6. Restoration and sealant status, radiographic caries findings, and
aggregate caries risk are separate clinical concepts and must not be encoded as
additional ICDAS lesion scores.

## Pulp sensibility observations

`PulpSensibilityObservationDE` records one or more of the following components:

- cold test;
- heat test; and
- electric pulp test.

Cold and heat tests use qualitative coded responses. An electric test can use
the same qualitative responses or a quantitative threshold. A quantitative
electric result requires `Observation.device` to identify the test device.

These tests assess neural response and therefore represent pulp sensibility,
not direct measurement of pulpal blood flow. Percussion, palpation, mobility,
and periapical findings remain separate observations.
