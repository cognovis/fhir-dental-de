// Beispiel: Klinischer Laborauftrag — Zirkonkrone auf Zahn 26
// Zeigt die Nutzung aller klinischen Extensions im DentalLabServiceRequestDE.

Instance: ExampleLabOrderZirkonkrone26
InstanceOf: DentalLabServiceRequestDE
Usage: #example
Title: "Laborauftrag: Zirkonkrone Zahn 26"
Description: "Beispiel fuer einen klinischen Laborauftrag: monolithische Zirkonkrone auf Zahn 26 (erster Molar oben links), Farbe A3, Stufenpraeparation, digitaler Workflow."

* status = #active
* intent = #order

* identifier[0].system = "https://example.dental/lab-orders"
* identifier[0].value = "LAB-2026-001234"

* category = DentalLabOrderTypeCS#festsitzend "Festsitzender Zahnersatz"

* code.text = "Monolithische Zirkonkrone Zahn 26"

* subject = Reference(Patient/example-patient)
* subject.display = "Max Mustermann"

* performer[0] = Reference(Organization/example-dental-lab)
* performer[0].display = "Zahntechnik Mueller GmbH"

// --- Betroffener Zahn ---
* bodySite[0] = $fdiCS#26 "Zahn 26"

// --- Klinische Extensions ---
* extension[restorationType].valueCodeableConcept = RestorationTypeCS#krone "Krone"
* extension[toothColor].valueCodeableConcept = VitaClassicalCS#A3 "A3"
* extension[material].valueCodeableConcept = DentalMaterialCS#zirkon "Zirkonoxid"
* extension[preparation].valueCodeableConcept = PreparationTypeCS#stufe "Stufenpraeparation"
* extension[antagonist].valueString = "Natuerliche Bezahnung, Zahn 36 mit Kompositfuellung"
* extension[occlusion].valueCodeableConcept = OcclusionConceptCS#front-eckzahn "Front-Eckzahn-Fuehrung"

// --- Freitext-Anweisungen ---
* note[0].text = "Bitte hoeckerunterstütztes Design. Leicht ueberkonturierte Approximalkontakte gewuenscht (Patient hat weite Zahnzwischenraeume). Farbverlauf zervikal etwas dunkler."

// --- Termin ---
* occurrencePeriod.end = "2026-04-18"

// --- Digitale Unterlagen (hier als Referenz) ---
* supportingInfo[0].display = "Intraoralscan Oberkiefer (STL)"
* supportingInfo[1].display = "Intraoralfotos (bukkal, okklusal, Farbabgleich)"
