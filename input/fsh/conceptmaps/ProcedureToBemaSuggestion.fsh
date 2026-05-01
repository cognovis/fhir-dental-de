// ConceptMap: SNOMED CT Röntgenverfahren → BEMA Röntgenpositionen
// Bildet klinische SNOMED-CT-Prozeduren auf die zugehörigen BEMA-Abrechnungspositionen ab.
// Dient als Kodierungsvorschlag bei der Erfassung zahnärztlicher Röntgenleistungen.
//
// Mapping:
//   241060007 "Plain X-ray of teeth"                    → Ae5000 (intraorale Röntgenaufnahme)
//   4381000179102 "Dental panoramic X-ray"              → Ae5002 (OPG/Panoramaschichtaufnahme)
//   363680008 "Radiographic imaging action" (fallback)  → Ae925  (allgemeine Röntgenaufnahme)

Instance: ProcedureToBemaSuggestion
InstanceOf: ConceptMap
Usage: #definition
Title: "SNOMED Röntgenverfahren → BEMA Vorschlag"
Description: "Vorschlagsmapping von SNOMED-CT-Röntgenprozeduren auf BEMA-Abrechnungspositionen. Unterstützt die automatische Kodierungsvorschlagsfunktion beim Erfassen von Röntgenleistungen im GKV-Bereich."

* name = "ProcedureToBemaSuggestionCM"
* url = "https://fhir.cognovis.de/dental/ConceptMap/procedure-to-bema-suggestion"
* status = #active
* experimental = false
* publisher = "cognovis GmbH"
* sourceCanonical = "http://snomed.info/sct"
* targetCanonical = "http://fhir.de/CodeSystem/kzbv/bema"

* group[0].source = "http://snomed.info/sct"
* group[0].target = "http://fhir.de/CodeSystem/kzbv/bema"

// 241060007 "Plain X-ray of teeth" → Ae5000 (Intraorale Röntgenaufnahme)
* group[0].element[0].code = #241060007
* group[0].element[0].display = "Plain X-ray of teeth"
* group[0].element[0].target[0].code = #Ae5000
* group[0].element[0].target[0].display = "BEMA-Ae5000 (Intraorale Röntgenaufnahme)"
* group[0].element[0].target[0].equivalence = #equivalent

// 4381000179102 "Dental panoramic X-ray" → Ae5002 (OPG)
* group[0].element[1].code = #4381000179102
* group[0].element[1].display = "Dental panoramic X-ray"
* group[0].element[1].target[0].code = #Ae5002
* group[0].element[1].target[0].display = "BEMA-Ae5002 (Panoramaschichtaufnahme/OPG)"
* group[0].element[1].target[0].equivalence = #equivalent

// 363680008 "Radiographic imaging action" → Ae925 (allgemeiner Fallback)
* group[0].element[2].code = #363680008
* group[0].element[2].display = "Radiographic imaging action"
* group[0].element[2].target[0].code = #Ae925
* group[0].element[2].target[0].display = "BEMA-Ae925 (Röntgenaufnahme allgemein)"
* group[0].element[2].target[0].equivalence = #wider
