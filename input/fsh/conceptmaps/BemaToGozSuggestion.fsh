// ConceptMap: BEMA Röntgenpositionen → GOZ Abrechnungsvorschläge
// Bildet die GKV-BEMA-Röntgencodes auf die entsprechenden GOZ-Privatpositionen ab.
// Dient als Abrechnungsvorschlag für die Konvertierung von Kassen- zu Privatleistungen.
//
// Mapping:
//   Ae925  → 0080 (Intraorale Röntgenaufnahme)
//   Ae5000 → 0080 (Intraorale Röntgenaufnahme)
//   Ae5002 → 0050 (Panoramaschichtaufnahme / OPG)
//   Ae5004 → 0060 (Fernröntgenseitenaufnahme / FRS)

Instance: BemaToGozSuggestion
InstanceOf: ConceptMap
Usage: #definition
Title: "BEMA Röntgen → GOZ Vorschlag"
Description: "Vorschlagsmapping von BEMA-Röntgenpositionen (Ae925, Ae5000, Ae5002, Ae5004) auf äquivalente GOZ-Privatpositionen. Kann als Abrechnungshilfe bei der Umstellung von GKV auf PKV/Selbstzahler verwendet werden."

* name = "BemaToGozSuggestionCM"
* url = "https://fhir.cognovis.de/dental/ConceptMap/bema-to-goz-suggestion"
* status = #active
* experimental = false
* publisher = "cognovis GmbH"
* sourceCanonical = "http://fhir.de/CodeSystem/kzbv/bema"
* targetCanonical = "http://fhir.de/CodeSystem/bzaek/goz"

* group[0].source = "http://fhir.de/CodeSystem/kzbv/bema"
* group[0].target = "http://fhir.de/CodeSystem/bzaek/goz"

// Ae925 → 0080 Intraorale Röntgenaufnahme
* group[0].element[0].code = #Ae925
* group[0].element[0].display = "BEMA-Ae925 (Intraorale Röntgenaufnahme/Periapikalaufnahme)"
* group[0].element[0].target[0].code = #0080
* group[0].element[0].target[0].display = "Intraorale Röntgenaufnahme"
* group[0].element[0].target[0].equivalence = #equivalent

// Ae5000 → 0080 Intraorale Röntgenaufnahme
* group[0].element[1].code = #Ae5000
* group[0].element[1].display = "BEMA-Ae5000 (Intraorale Röntgenaufnahme)"
* group[0].element[1].target[0].code = #0080
* group[0].element[1].target[0].display = "Intraorale Röntgenaufnahme"
* group[0].element[1].target[0].equivalence = #equivalent

// Ae5002 → 0050 Panoramaschichtaufnahme (OPG)
* group[0].element[2].code = #Ae5002
* group[0].element[2].display = "BEMA-Ae5002 (Panoramaschichtaufnahme/OPG)"
* group[0].element[2].target[0].code = #0050
* group[0].element[2].target[0].display = "Panoramaschichtaufnahme"
* group[0].element[2].target[0].equivalence = #equivalent

// Ae5004 → 0060 Fernröntgenseitenaufnahme (FRS) — Hauptvorschlag
//           0090 DVT als Zusatzvorschlag (wider-than)
* group[0].element[3].code = #Ae5004
* group[0].element[3].display = "BEMA-Ae5004 (Fernröntgenseitenaufnahme/DVT)"
* group[0].element[3].target[0].code = #0060
* group[0].element[3].target[0].display = "Fernröntgenseitenaufnahme"
* group[0].element[3].target[0].equivalence = #equivalent
* group[0].element[3].target[1].code = #0090
* group[0].element[3].target[1].display = "Digitale Volumentomographie"
* group[0].element[3].target[1].equivalence = #wider
