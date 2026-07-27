# Periodontal Measurements

`PeriodontalObservationDE` is the canonical exchange profile for structured,
site-level periodontal measurements. Positional strings from source systems are
ingest formats and are not part of the public clinical terminology.

Each repeated probing-depth, recession, bleeding-on-probing, and clinical
attachment-loss component carries the
`periodontal-measurement-site` extension. The extension uses one of six
vendor-neutral sites:

- mesiobuccal
- buccal
- distobuccal
- mesiolingual
- lingual
- distolingual

Component order has no clinical meaning. Consumers identify a measurement by
the component code and its measurement-site extension.

The G-BA PAR-Richtlinie requires measurements at at least two sites per tooth,
including mesioapproximal and distoapproximal sites. The six-site model is an
interoperability superset and does not state that six sites are required for
every workflow.

Clinical attachment loss is exchanged as an explicit quantity at the same
site. A producer may derive it from probing depth and recession only when the
source sign convention and both inputs are known. Consumers must not infer it
silently from incomplete data.

`PeriImplantObservationDE` reuses the same six-site contract. Each observation
focuses on one `DentalImplantDE` Device and also carries the corresponding FDI
region. Probing depth, bleeding, and suppuration are site-specific. Implant
mobility is boolean; tooth-mobility grades are not valid for an implant.
Radiographic bone loss and a resulting diagnosis remain separate resources and
link explicitly to the implant and peri-implant findings.
