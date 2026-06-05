// Example: Routine dental finding (BEMA-01) — initial examination

Alias: $bema = https://fhir.cognovis.de/dental/CodeSystem/bema-01-mindestpflicht-befund

Instance: ExampleRoutineBefund
InstanceOf: RoutineBefundDE
Usage: #example
Title: "Example BEMA-01 Routine Finding"
Description: "Routine dental finding documentation for BEMA-01 (initial examination). Patient covered by public insurance (GKV). Records findings from initial comprehensive examination (eingehende Untersuchung)."

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

// BEMA-01 routine finding code — Zahnstein (tartar buildup, common BEMA-01 finding)
* code = $bema#zst "Zahnstein"

* subject = Reference(Patient/pat-gkv-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-02-10T09:00:00+01:00"

// Oral examination encounter
* encounter = Reference(Encounter/enc-dental-01)

// Overall status of finding
* valueString = "Initial comprehensive examination completed. Patient in good general oral health with minor findings documented separately."
