Extension: ZeTherapiekuerzelExt
Id: ze-therapiekuerzel
Title: "ZE Therapiekürzel"
Description: """
Therapiekürzel für die geplante Zahnersatz-Versorgung auf einem `CarePlan`. Codes können aus zwei sich ergänzenden Code-Systemen kommen:

* **`http://fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel`** — Authoritative KZBV-DPF-Liste (EBZ Anlage 2, 43 Codes wie `K`, `B`, `T`, `SB`, `SK`, `T2`). Verwende dies für eHKP-konforme Therapie-Notation.
* **`https://fhir.cognovis.de/dental/CodeSystem/ze-therapiekuerzel`** — Cognovis-interner Status (KFO-Retainer, Reparaturen, Unterfütterungen — Konzepte ausserhalb des EBZ-ZE-Workflows).

Binding ist `extensible`: beide Code-Systeme sind valide. Bei lexikalisch überlappenden Codes (`K`, `B`, `T`, `E`) ist die `system`-URL entscheidend.
"""
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/ze-therapiekuerzel"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "CarePlan"

* value[x] only code
* value[x] from ZeTherapiekuerzelVS (extensible)
* value[x] ^short = "Therapiekürzel (KZBV-DPF authoritativ, oder cognovis-Status-Ergänzung)"
