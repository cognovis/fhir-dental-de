// Verlangensleistung-Markierung nach § 1 Abs. 2 Satz 2 GOZ
//
// Requested services without medical necessity use the separate written
// treatment-and-cost-plan path required by GOZ section 2(3).
//
// Steuerliche Konsequenz: Da KEINE Heilbehandlung im Sinne § 4 Nr. 14a UStG vorliegt,
// gilt der USt-Regelsatz von 19 %. Die Tax-Pattern-Anwendung erfolgt
// über TaxCategoryExt=S (vererbt von ChargeItemPraxisDe).
//
// The DocumentReference is required evidence for that written plan.

Extension: VerlangensleistungExt
Id: verlangensleistung
Title: "Verlangensleistung (§ 1 Abs. 2 Satz 2 GOZ)"
Description: "Marks a requested service without medical necessity and links the written treatment and cost plan required by GOZ §2(3)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/verlangensleistung"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"

* extension contains
    verlangensleistung 1..1 MS and
    verlangensleistungBeleg 1..1 MS

* extension[verlangensleistung].value[x] only boolean
* extension[verlangensleistung].valueBoolean = true
* extension[verlangensleistung].value[x] ^short = "Ist Verlangensleistung (true) oder Heilbehandlung (false/absent)"
* extension[verlangensleistung].value[x] ^definition = "Wenn true, wurde die Leistung vom Patienten ohne medizinische Indikation verlangt. Triggert den USt-Regelsatz von 19 % via TaxCategoryExt=S."

* extension[verlangensleistungBeleg].value[x] only Reference(DocumentReference)
* extension[verlangensleistungBeleg].value[x] ^short = "Written treatment and cost plan under GOZ §2(3)"
* extension[verlangensleistungBeleg].value[x] ^definition = "Reference to the written plan that identifies the requested services, their fees, the requested-service status, and the possible reimbursement limitation."
