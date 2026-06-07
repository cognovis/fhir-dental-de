// Verlangensleistung-Markierung nach § 1 Abs. 2 Satz 2 GOZ
//
// Verlangensleistungen sind zahnärztliche Leistungen OHNE medizinische Indikation,
// die der Patient ausdrücklich verlangt (z.B. Bleaching, Veneer ohne Indikation,
// Schmucksteine/Twinkles). § 2 Abs. 3 GOZ schließt die Vereinbarungspflicht
// nach § 2 Abs. 1+2 GOZ aus — Faktor und Vergütung sind frei verhandelbar.
//
// Steuerliche Konsequenz: Da KEINE Heilbehandlung im Sinne § 4 Nr. 14a UStG vorliegt,
// gilt der USt-Regelsatz von 19 %. Die Tax-Pattern-Anwendung erfolgt in fdde-8vf
// über TaxCategoryExt=S (vererbt von ChargeItemPraxisDe).
//
// Beweissicherung: Empfohlen — verlangensleistungBeleg als DocumentReference auf
// dokumentiertes Patientenverlangen (Aufklärungsprotokoll, Behandlungsvertrag).

Extension: VerlangensleistungExt
Id: verlangensleistung
Title: "Verlangensleistung (§ 1 Abs. 2 Satz 2 GOZ)"
Description: "Markiert eine GOZ-Leistung als Verlangensleistung ohne medizinische Indikation. Konsequenzen: § 2 GOZ Vereinbarungspflicht entfällt; USt-Regelsatz 19 % (KEINE Heilbehandlung i.S. § 4 Nr. 14a UStG)."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/verlangensleistung"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"

* extension contains
    verlangensleistung 1..1 MS and
    verlangensleistungBeleg 0..1 MS

* extension[verlangensleistung].value[x] only boolean
* extension[verlangensleistung].value[x] ^short = "Ist Verlangensleistung (true) oder Heilbehandlung (false/absent)"
* extension[verlangensleistung].value[x] ^definition = "Wenn true, wurde die Leistung vom Patienten ohne medizinische Indikation verlangt. Triggert den USt-Regelsatz von 19 % via TaxCategoryExt=S."

* extension[verlangensleistungBeleg].value[x] only Reference(DocumentReference)
* extension[verlangensleistungBeleg].value[x] ^short = "Beleg des Patientenverlangens (Aufklärungsprotokoll, Behandlungsvertrag)"
* extension[verlangensleistungBeleg].value[x] ^definition = "Empfohlen aus Beweisgründen: Verweis auf eine DocumentReference, die das ausdrückliche Patientenverlangen dokumentiert. Aufklärungsprotokoll, schriftlicher Behandlungsvertrag oder gleichwertige Aufzeichnung."
