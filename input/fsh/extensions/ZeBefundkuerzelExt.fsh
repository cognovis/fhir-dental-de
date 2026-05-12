Extension: ZeBefundkuerzelExt
Id: ze-befundkuerzel
Title: "ZE Befundkürzel"
Description: """
Befundkürzel für den Zahnersatz-Ist-Zustand auf einem `CarePlan`. Codes können aus zwei sich ergänzenden Code-Systemen kommen:

* **`http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel`** — Authoritative KZBV-DPF-Liste (EBZ Anlage 2, 33 Codes wie `a`, `b`, `e`, `k`, `pw`, `ww`, `x`). Verwende dies für eHKP-konforme HKP-Befund-Notation.
* **`https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel`** — Cognovis-interner Ergänzungs-Status (z.B. `kd`=Krone defekt, `Atx`=Attachment, `MagA`=Magnetanker — Konzepte ausserhalb des EBZ-Workflows).

Binding ist `extensible`: beide Code-Systeme sind valide. Achtung Semantik-Konflikte bei überlappenden Codes (`x`, `B`, `K`, `e`, `b`) — die `system`-URL der Coding/code ist entscheidend. Siehe `docs/adr/ADR-004` in fhir-terminology-de.
"""
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-befundkuerzel"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only code
* value[x] from ZeBefundkuerzelVS (extensible)
* value[x] ^short = "Befundkürzel (KZBV-DPF authoritativ, oder cognovis-Status-Ergänzung)"
