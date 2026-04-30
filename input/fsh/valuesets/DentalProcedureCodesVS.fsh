ValueSet: DentalProcedureCodesVS
Id: dental-procedure-codes
Title: "Zahnärztliche Leistungscodes"
Description: "Vereinigtes ValueSet für zahnärztliche Leistungen: BEMA (GKV), GOZ (PKV) und OPS (chirurgische Eingriffe)."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/dental-procedure-codes"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* include codes from system BemaCS
* include codes from system GozCS
* include codes from system $ops
  where concept descendent-of #5-23   // Operationen an den Zähnen
* include codes from system $ops
  where concept descendent-of #5-24   // Operationen am Kiefer

Alias: $ops = http://fhir.de/CodeSystem/bfarm/ops
