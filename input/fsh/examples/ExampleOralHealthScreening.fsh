// Example: Oral Health Screening — Bruxismus + Raucherstatus + Xerostomie

Alias: $sct = http://snomed.info/sct

Instance: ExampleOralHealthScreening
InstanceOf: OralHealthScreeningDE
Usage: #example
Title: "Beispiel Oral Health Screening"
Description: "Ganzheitliches orales Screening: Bruxismus vorhanden, Mundatmung vorhanden, Raucherstatus ehemaliger Raucher, leichte Xerostomie. Patient Aylin Oezdemir. Typischer Screening-Befund bei Erstvorstellung oder Recall."

* status = #final

* category[dental] = https://fhir.cognovis.de/dental/CodeSystem/dental-category#dental "Dental"

* code = $sct#110353005 "Parafunctional activity"
* code.text = "Oral Health Screening"

* subject = Reference(Patient/pat-gkv-dental-01)

* performer[0] = Reference(Organization/org-dental-mvz)

* effectiveDateTime = "2026-03-15T10:00:00+01:00"

// Bruxismus: vorhanden
* component[bruxism].code = $sct#25780007 "Bruxism"
* component[bruxism].valueCodeableConcept.coding = $sct#52101004 "Present"
* component[bruxism].valueCodeableConcept.text = "Bruxismus vorhanden — Abrasionsspuren an 16, 26, 36, 46. Schiene empfohlen."

// Tongue thrust: nicht vorhanden
* component[tongueThrust].code = $sct#289147003 "Tongue thrust present"
* component[tongueThrust].valueBoolean = false

// Cheek biting: nicht vorhanden
* component[cheekBiting].code = $sct#52709000 "Cheek biting"
* component[cheekBiting].valueBoolean = false

// Mundatmung: vorhanden
* component[mouthBreathing].code = $sct#79688008 "Mouth breathing"
* component[mouthBreathing].valueBoolean = true

// Raucherstatus: ehemaliger Raucher
* component[smokingStatus].code = $sct#229819007 "Tobacco use and target"
* component[smokingStatus].valueCodeableConcept.coding = $sct#8517006 "Ex-smoker"
* component[smokingStatus].valueCodeableConcept.text = "Ehemaliger Raucher (aufgehoert 2022)"

// Xerostomie: leicht vorhanden
* component[xerostomia].code = $sct#87715008 "Xerostomia"
* component[xerostomia].valueCodeableConcept.coding = $sct#52101004 "Present"
* component[xerostomia].valueCodeableConcept.text = "Leichte Xerostomie — moeglicherweise medikamenteninduziert (Antidepressiva)"
