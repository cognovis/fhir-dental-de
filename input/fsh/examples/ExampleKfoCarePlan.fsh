// Example: KFO-Plan Angle II-1, KIG 4
// SWS 2.0 Satzart 10 — KFO-Behandlungsplan

Alias: $icd10gm = http://fhir.de/CodeSystem/bfarm/icd-10-gm

Instance: ExampleKfoCarePlan
InstanceOf: DentalCarePlanDE
Usage: #example
Title: "Beispiel KFO-Behandlungsplan Angle II/1 KIG 4"
Description: "Kieferorthopädischer Behandlungsplan für Angle-Klasse II/1 mit KIG-Stufe 4. Festsitzende Apparatur, aktive Behandlungsphase. Beginn 2026-02-01, geplantes Ende 2028-01-31. Patient Klaus Bergmann."

* extension[kfoBehandlungsphase].valueCode = https://fhir.cognovis.de/dental/CodeSystem/kfo-behandlungsphase#aktiv "Aktive Behandlungsphase"
* extension[kfoApparatusType].valueCode = https://fhir.cognovis.de/dental/CodeSystem/kfo-apparatus-type#festsitzend "Festsitzende Apparatur"

* identifier[0].system = "https://example-dental-practice.de/kfo-plan"
* identifier[0].value = "KFO-2026-0001"

* status = #active
* intent = #plan

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"
* category[planType] = https://fhir.cognovis.de/dental/CodeSystem/dental-care-plan-type#kfo "Kieferorthopaedie (KFO)"

* subject = Reference(Patient/pat-gkv-01)

* created = "2026-01-10"

* period.start = "2026-02-01"
* period.end = "2028-01-31"

* title = "KFO-Behandlungsplan: Angle Klasse II/1, KIG 4, Festsitzende Apparatur"

* description = "KFO-Behandlung nach §28 Abs. 2 SGB V. Indikation: Angle-Klasse II/1 mit vergrößertem Overjet (>9mm), KIG-Stufe 4 (kassenärztlich genehmigungspflichtig ab KIG 3). Geplante Behandlung: Multiband-Apparatur Ober- und Unterkiefer, voraussichtliche Behandlungsdauer 24 Monate. Retentionsphase nicht in diesem Plan enthalten."

// KFO-Diagnose mit Angle-Klasse und KIG-Punkten
* addresses[0] = Reference(ExampleKfoDiagnose)

// -----------------------------------------------------------------------
// Inline KFO Diagnose (Condition mit Angle-Klasse + KIG-Punkten)
// -----------------------------------------------------------------------
Instance: ExampleKfoDiagnose
InstanceOf: Condition
Usage: #example
Title: "Beispiel KFO-Diagnose Angle II/1 KIG 4"
Description: "Kieferorthopädische Diagnose: Angle-Klasse II/1 mit vergrößertem Overjet. KIG-Stufe 4. Konform zu DentalConditionDE."

* meta.profile[0] = "https://fhir.cognovis.de/dental/StructureDefinition/dental-condition"

* extension[0].url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-angle-klasse"
* extension[0].valueCode = https://fhir.cognovis.de/dental/CodeSystem/kfo-angle-klasse#II-1 "Angle Klasse II/1"

* extension[1].url = "https://fhir.cognovis.de/dental/StructureDefinition/kfo-kig-punkte"
* extension[1].valueInteger = 4

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"

* category[0] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $icd10gm#K07.12 "Distalbiss, Angle-Klasse II"
* code.text = "Angle-Klasse II/1: Distalbiss mit proklinierter Oberkieferfront, Overjet > 9 mm"

* subject = Reference(Patient/pat-gkv-01)

* onsetDateTime = "2026-02-01"
* recordedDate = "2026-02-01"
