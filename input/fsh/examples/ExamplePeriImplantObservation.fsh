Alias: $periodontalSite = https://fhir.cognovis.de/dental/CodeSystem/periodontal-measurement-site

Instance: ExamplePeriImplantInflammation36
InstanceOf: PeriImplantObservationDE
Usage: #example
Title: "Inflamed Peri-Implant Site at Position 36"
Description: "Site-level probing, bleeding, suppuration, and stable implant mobility findings linked to a separate bone-loss observation."
* status = #final
* code = PeriImplantFindingCS#assessment
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-20"
* focus = Reference(ExampleDentalImplant36)
* bodySite = $fdiCS#36
* hasMember = Reference(ExamplePeriImplantBoneLoss36)
* component[probingDepth][0].extension[measurementSite].valueCodeableConcept = $periodontalSite#mesiobuccal
* component[probingDepth][0].valueQuantity = 6 'mm'
* component[probingDepth][1].extension[measurementSite].valueCodeableConcept = $periodontalSite#buccal
* component[probingDepth][1].valueQuantity = 5 'mm'
* component[bop][0].extension[measurementSite].valueCodeableConcept = $periodontalSite#mesiobuccal
* component[bop][0].valueBoolean = true
* component[suppuration][0].extension[measurementSite].valueCodeableConcept = $periodontalSite#mesiobuccal
* component[suppuration][0].valueBoolean = true
* component[implantMobility].valueBoolean = false

Instance: ExamplePeriImplantBoneLoss36
InstanceOf: RadiographicBoneLossObservationDE
Usage: #example
Title: "Radiographic Bone Loss around Implant 36"
Description: "Radiographic evidence remains a separate Observation focused on the implant."
* status = #final
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-20"
* bodySite = $fdiCS#36
* focus = Reference(ExampleDentalImplant36)
* valueQuantity = 25 '%'
* component[patientAgeAtMeasurement].valueInteger = 67

Instance: ExamplePeriImplantitisCondition36
InstanceOf: Condition
Usage: #example
Title: "Peri-Implantitis Diagnosis at Position 36"
Description: "The diagnosis is separate from the site measurements and radiographic evidence."
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category[0] = DentalCategoryCS#dental
* code = http://snomed.info/sct#699422003
* subject = Reference(Patient/pat-beihilfe-01)
* bodySite = $fdiCS#36
* recordedDate = "2026-07-20"
* evidence[0].detail[0] = Reference(ExamplePeriImplantInflammation36)
* evidence[0].detail[1] = Reference(ExamplePeriImplantBoneLoss36)

Instance: ExampleHealthyPeriImplant36
InstanceOf: PeriImplantObservationDE
Usage: #example
Title: "Healthy Peri-Implant Measurements at Position 36"
Description: "Negative finding example with shallow probing, no bleeding, no suppuration, and no mobility."
* status = #final
* code = PeriImplantFindingCS#assessment
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(Organization/org-dental-mvz)
* effectiveDateTime = "2026-07-20"
* focus = Reference(ExampleDentalImplant36)
* bodySite = $fdiCS#36
* component[probingDepth][0].extension[measurementSite].valueCodeableConcept = $periodontalSite#buccal
* component[probingDepth][0].valueQuantity = 3 'mm'
* component[bop][0].extension[measurementSite].valueCodeableConcept = $periodontalSite#buccal
* component[bop][0].valueBoolean = false
* component[suppuration][0].extension[measurementSite].valueCodeableConcept = $periodontalSite#buccal
* component[suppuration][0].valueBoolean = false
* component[implantMobility].valueBoolean = false
