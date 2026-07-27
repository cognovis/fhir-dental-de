### Code Systems

This implementation guide defines the following code systems for German dental terminology.
External catalog systems such as BEMA and BEL-II are referenced by canonical URL and supplied by dedicated terminology packages.

#### No local dental specialty CodeSystem

Dental `PractitionerRole.specialty` uses **SNOMED CT** (`http://snomed.info/sct`) via [DentalPractitionerSpecialty](ValueSet-dental-practitioner-specialty.html).
This IG **must not** define a local dental specialty CodeSystem while SNOMED CT covers the required concepts (there is no KZBV equivalent to KBV BAR2-WBO for dental specialties).
Runtime displays and validation for those SCTIDs come from the gated package `de.cognovis.terminology.dental.snomed`; the public IG carries code references only.

#### Billing Code Systems
- [GOZ](CodeSystem-goz.html) — Gebührenordnung für Zahnärzte (PKV)
- [GOÄ Zahnarzt](CodeSystem-goae-zahn.html) — Relevante GOÄ-Positionen für Zahnärzte
- [beb'97](CodeSystem-beb97.html) — Private zahntechnische Leistungen

#### Clinical Code Systems
- SWS 2.0 tooth status (`https://fhir.cognovis.de/dental/CodeSystem/sws2-zahnstatus`) — published external tooth-chart terminology from `de.cognovis.terminology.dental.sws-zahnstatus`
- [Oral Health Screening Component](CodeSystem-oral-health-screening-component.html) — structural component identifiers only; bruxism type and grade values remain in the published upstream terminology
- [Dental Category](CodeSystem-dental-category.html) — Dental resource category marker
- [Tooth Surfaces](CodeSystem-tooth-surfaces.html) — Zahnflächen (M/D/O/I/B/V/L/P)
- [BEMA Befundklasse](CodeSystem-bema-befundklasse.html) — Befundklassen (c/k/f/e/b)
- [Periodontal Measurement Site](CodeSystem-periodontal-measurement-site.html) — Six vendor-neutral tooth measurement sites
- [PSI Score](CodeSystem-psi-score.html) — PSI scores 0 through 4
- [Prophylaxis Index Method](CodeSystem-prophylaxis-index-method.html) — API, QHI, PI, SBI, PBI, and GI assessment methods
- [Dental Deposit Type](CodeSystem-dental-deposit-type.html) — Biofilm and calculus
- [Dental Deposit Vertical Location](CodeSystem-dental-deposit-vertical-location.html) — Supra-, gingival, and subgingival location
- [Dental Deposit Surface](CodeSystem-dental-deposit-surface.html) — Tooth, root, implant, and pontic surfaces
- [Caries Risk Level](CodeSystem-kariesrisiko-level.html) — IG-owned qualitative aggregate caries-risk levels

#### Administrative Code Systems
- [KZV Regionen](CodeSystem-kzv-regionen.html) — 17 Kassenzahnärztliche Vereinigungen
- [ZE Befundkürzel](CodeSystem-ze-befundkuerzel.html) — cognovis-interner Befund-Status (ergänzend, nicht ersetzend; KZBV-DPF ist authoritativ — s.u.)
- [ZE Therapiekürzel](CodeSystem-ze-therapiekuerzel.html) — cognovis-interner Therapie-Status (ergänzend)

#### Die drei KZBV-Taxonomien für Zahnersatz-Workflows

Im Dental-IG kommen drei *unterschiedliche* KZBV-publizierte Code-Listen zum Tragen, die im praktischen Gebrauch oft verwechselt werden. Sie haben jeweils ihren eigenen Workflow-Zweck:

| Taxonomie | URL / CS | Zweck | Codes | Quelle |
|---|---|---|---|---|
| **Festzuschuss-Befunde** | `https://fhir.cognovis.de/dental/CodeSystem/festzuschuss-befund` | Anspruchsbegründung § 55 SGB V (Festzuschuss-Berechnung) | 54 numerische Codes 1.1–8.6 | KZBV FZ-Kompendium |
| **KZBV-DPF-Befundkürzel** | `http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel` (Paket `de.cognovis.terminology.dental.dpf-kuerzel@2022.0.0`) | Zahnschema-Notation im eHKP / Papier-HKP (verbindlich ab 2022) | 33 alphabetische Codes (`a`, `ab`, `b`, `e`, `k`, `pw`, `ww`, `x`, `)(`) | KZBV EBZ Anlage 2 |
| **KZBV-DPF-Therapiekürzel** | `http://fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel` (selbes Paket) | Therapieplanung im eHKP/HKP | 43 alphabetische Codes (`K`, `B`, `T`, `SB`, `SK`, `T2`, …) | KZBV EBZ Anlage 2 |

Daneben existieren die cognovis-internen **`ze-befundkuerzel`** und **`ze-therapiekuerzel`** CSes — sie sind **ergänzend**, decken klinische Status-Codes ab die in KZBV-DPF nicht existieren (z.B. "Krone defekt", "Magnetanker", "KFO-Retainer", "Reparatur Brücke").

> **Wichtig**: Lexikalisch überlappende Codes (`x`, `B`, `K`, `e`, `b`) haben **unterschiedliche Semantik** zwischen den Code-Systemen. Bei `Coding` immer die `system`-URL explizit setzen — sie ist der einzig verlässliche Diskriminator zwischen den parallelen Befund-Taxonomien.

#### Tooth-status migration

The draft canonical `https://fhir.cognovis.de/dental/CodeSystem/dental-befund-status`
is retired. Producers use
`https://fhir.cognovis.de/dental/CodeSystem/sws2-zahnstatus` for observed
tooth-chart status and bind against
`https://fhir.cognovis.de/dental/ValueSet/sws2-zahnstatus-complete`.
Tooth status is carried by `DentalFindingDE.valueCodeableConcept`, never by
`Condition.stage`.

SWS tooth findings, KZBV DPF prosthetic abbreviations, and the local ZE
planning extensions are separate namespaces. A matching lexical code does not
permit conversion without an explicit mapping.
