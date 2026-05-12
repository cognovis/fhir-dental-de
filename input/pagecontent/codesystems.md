### Code Systems

This implementation guide defines the following code systems for German dental terminology:

#### Billing Code Systems
- [BEMA](CodeSystem-bema.html) — Bewertungsmaßstab zahnärztlicher Leistungen (GKV)
- [GOZ](CodeSystem-goz.html) — Gebührenordnung für Zahnärzte (PKV)
- [GOÄ Zahnarzt](CodeSystem-goae-zahn.html) — Relevante GOÄ-Positionen für Zahnärzte
- [BEL-II](CodeSystem-bel-ii.html) — Zahntechnischer Leistungskatalog
- [beb'97](CodeSystem-beb97.html) — Private zahntechnische Leistungen

#### Clinical Code Systems
- [Dental Befundstatus](CodeSystem-dental-befund-status.html) — KZBV Zahnschema-Befundstatus
- [Dental Category](CodeSystem-dental-category.html) — Dental resource category marker
- [Tooth Surfaces](CodeSystem-tooth-surfaces.html) — Zahnflächen (M/D/O/I/B/V/L/P)
- [BEMA Befundklasse](CodeSystem-bema-befundklasse.html) — Befundklassen (c/k/f/e/b)

#### Administrative Code Systems
- [KZV Regionen](CodeSystem-kzv-regionen.html) — 17 Kassenzahnärztliche Vereinigungen
- [ZE Befundkürzel](CodeSystem-ze-befundkuerzel.html) — cognovis erweiterte Dental-Status-Taxonomie (NICHT identisch mit offizieller KZBV-DPF-Liste — siehe `http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel`)
- [ZE Therapiekürzel](CodeSystem-ze-therapiekuerzel.html) — cognovis erweiterte Dental-Therapie-Taxonomie (NICHT identisch mit offizieller KZBV-DPF-Liste — siehe `http://fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel`)

> **Namespace-Hinweis (ADR-004 in fhir-terminology-de):** Die hier definierten `ze-befundkuerzel` und `ze-therapiekuerzel` sind cognovis-redaktionelle Erweiterungen für interne Dental-Workflows. Die **authoritative KZBV-DPF-Kürzel-Liste** (EBZ Anlage 2, Pflicht für eHKP-Anträge ab 2022-01-01) wird durch `de.cognovis.terminology.dental.dpf-kuerzel@2022.0.0` unter dem `http://fhir.de/CodeSystem/kzbv/dpf-*` Namespace verteilt. Achtung Semantik-Konflikte: einige Codes (`e`, `k`, `b`) bedeuten in beiden CSes Unterschiedliches.
