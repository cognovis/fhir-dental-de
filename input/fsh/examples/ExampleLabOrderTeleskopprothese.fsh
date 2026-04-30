// Beispiel: Klinischer Laborauftrag — Teleskopprothese Unterkiefer

Instance: ExampleLabOrderTeleskopUK
InstanceOf: DentalLabServiceRequestDE
Usage: #example
Title: "Laborauftrag: Teleskopprothese UK auf Implantaten"
Description: "Beispiel fuer einen kombinierten Laborauftrag: Teleskopprothese im Unterkiefer auf 4 Implantaten (regio 33, 35, 43, 45), NEM-Primaerteile, Modellguss-Sekundaerstruktur."

* status = #active
* intent = #order

* identifier[0].system = "https://example.dental/lab-orders"
* identifier[0].value = "LAB-2026-001235"

* category = DentalLabOrderTypeCS#kombiniert "Kombinierter Zahnersatz"

* code.text = "Teleskopprothese UK auf 4 Implantaten"

* subject = Reference(Patient/example-patient)
* subject.display = "Erika Musterfrau"

* performer[0] = Reference(Organization/example-dental-lab)
* performer[0].display = "Zahntechnik Mueller GmbH"

// --- Betroffene Zaehne / Implantate ---
* bodySite[0] = $fdiCS#33 "Zahn 33"
* bodySite[1] = $fdiCS#35 "Zahn 35"
* bodySite[2] = $fdiCS#43 "Zahn 43"
* bodySite[3] = $fdiCS#45 "Zahn 45"

// --- Restaurationstypen (mehrfach bei kombinierter Versorgung) ---
* extension[restorationType][0].valueCodeableConcept = RestorationTypeCS#teleskop "Teleskopprothese"
* extension[restorationType][1].valueCodeableConcept = RestorationTypeCS#implantat-krone "Implantatkrone"

// --- Material (Geruest + Verblendung separat) ---
* extension[material][0].valueCodeableConcept = DentalMaterialCS#nem "NEM"
* extension[material][0].valueCodeableConcept.text = "NEM-Primaerteleskope"
* extension[material][1].valueCodeableConcept = DentalMaterialCS#pmma "PMMA"
* extension[material][1].valueCodeableConcept.text = "PMMA-Prothesenbasis + Zaehne"

* extension[toothColor].valueCodeableConcept = VitaClassicalCS#A2 "A2"

* extension[occlusion].valueCodeableConcept = OcclusionConceptCS#bilateral-balanciert "Bilateral balanciert"

// --- Implantat-Angaben ---
* extension[implantAbutment].extension[implantSystem].valueString = "Straumann BLT, SLActive"
* extension[implantAbutment].extension[abutmentType].valueString = "Titanklebebasis"
* extension[implantAbutment].extension[platformDiameter].valueDecimal = 4.1

* extension[antagonist].valueString = "Restbezahnung OK mit Modellgussprothese"

// --- Anweisungen ---
* note[0].text = "Primaerteile parallel ausrichten (gemeinsame Einschubrichtung). Friktion mittelfest einstellen. Prothesenrand lingual verstaerkt (Patient bruxiert)."

* occurrencePeriod.end = "2026-05-02"

* supportingInfo[0].display = "Intraoralscan UK mit Scanflags auf allen 4 Implantaten"
* supportingInfo[1].display = "Zentrikregistrat (Wachsbiss)"
