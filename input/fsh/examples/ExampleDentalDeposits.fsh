Alias: $depositType = https://fhir.cognovis.de/dental/CodeSystem/dental-deposit-type
Alias: $depositVertical = https://fhir.cognovis.de/dental/CodeSystem/dental-deposit-vertical-location
Alias: $depositSurface = https://fhir.cognovis.de/dental/CodeSystem/dental-deposit-surface
Alias: $fdiCS = http://terminology.hl7.org/CodeSystem/ex-tooth

Instance: ExampleSubgingivalToothDeposit
InstanceOf: DentalDepositObservationDE
Usage: #example
Title: "Subgingival Calculus on a Tooth Root"
* status = #final
* code = $depositType#calculus
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-02-05T10:00:00+01:00"
* bodySite = $fdiCS#16
* extension[verticalLocation].valueCodeableConcept = $depositVertical#subgingival
* extension[depositSurface].valueCodeableConcept = $depositSurface#subgingival-root

Instance: ExampleImplantBiofilmDeposit
InstanceOf: DentalDepositObservationDE
Usage: #example
Title: "Biofilm on an Implant Surface"
* status = #final
* code = $depositType#biofilm
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-02-05T10:05:00+01:00"
* bodySite = $fdiCS#46
* extension[verticalLocation].valueCodeableConcept = $depositVertical#gingival
* extension[depositSurface].valueCodeableConcept = $depositSurface#implant-surface

Instance: ExamplePonticCalculusDeposit
InstanceOf: DentalDepositObservationDE
Usage: #example
Title: "Supragingival Calculus on a Pontic"
* status = #final
* code = $depositType#calculus
* subject = Reference(Patient/pat-beihilfe-01)
* performer = Reference(PractitionerRole/role-schoell-gibitzenhof)
* effectiveDateTime = "2026-02-05T10:10:00+01:00"
* bodySite = $fdiCS#14
* extension[verticalLocation].valueCodeableConcept = $depositVertical#supragingival
* extension[depositSurface].valueCodeableConcept = $depositSurface#pontic
