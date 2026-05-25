### Code Systems

This implementation guide defines the following code systems for German dental terminology.
External catalog systems such as BEMA and BEL-II are referenced by canonical URL and supplied by dedicated terminology packages.

#### Billing Code Systems
- [GOZ](CodeSystem-goz.html) — Gebührenordnung für Zahnärzte (PKV)
- [GOÄ Zahnarzt](CodeSystem-goae-zahn.html) — Relevante GOÄ-Positionen für Zahnärzte
- [beb'97](CodeSystem-beb97.html) — Private zahntechnische Leistungen

#### Clinical Code Systems
- [Dental Befundstatus](CodeSystem-dental-befund-status.html) — KZBV Zahnschema-Befundstatus
- [Dental Category](CodeSystem-dental-category.html) — Dental resource category marker
- [Tooth Surfaces](CodeSystem-tooth-surfaces.html) — Zahnflächen (M/D/O/I/B/V/L/P)
- [BEMA Befundklasse](CodeSystem-bema-befundklasse.html) — Befundklassen (c/k/f/e/b)

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

> **Wichtig**: Lexikalisch überlappende Codes (`x`, `B`, `K`, `e`, `b`) haben **unterschiedliche Semantik** zwischen den Code-Systemen. Bei `Coding` immer die `system`-URL explizit setzen. Volle Hintergrund-Doku: `docs/adr/ADR-004-dental-befund-namespaces.md` in `fhir-terminology-de`.
