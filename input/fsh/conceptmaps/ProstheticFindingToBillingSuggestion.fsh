Instance: ProsthesisFindingToBemaSuggestion
InstanceOf: ConceptMap
Usage: #definition
Title: "Removable Prosthesis Finding to BEMA Suggestion"
Description: "Non-authoritative candidate mapping from technical removable-prosthesis findings to BEMA repair positions. A finding never establishes billability by itself."
* name = "ProsthesisFindingToBemaSuggestion"
* id = "prosthesis-finding-to-bema-suggestion"
* url = "https://fhir.cognovis.de/dental/ConceptMap/prosthesis-finding-to-bema-suggestion"
* status = #active
* experimental = false
* publisher = "cognovis GmbH"
* sourceCanonical = "https://fhir.cognovis.de/dental/ValueSet/prosthesis-finding"
* targetUri = "http://fhir.de/CodeSystem/kzbv/bema"
* group.source = "https://fhir.cognovis.de/dental/CodeSystem/prosthetic-device-finding"
* group.target = "http://fhir.de/CodeSystem/kzbv/bema"
* group.element[0].code = #base-fracture
* group.element[0].target[0].code = #100a
* group.element[0].target[0].equivalence = #relatedto
* group.element[0].target[1].code = #100b
* group.element[0].target[1].equivalence = #relatedto
* group.element[1].code = #clasp-fracture
* group.element[1].target[0].code = #100a
* group.element[1].target[0].equivalence = #relatedto
* group.element[1].target[1].code = #100b
* group.element[1].target[1].equivalence = #relatedto
* group.element[2].code = #extension-required
* group.element[2].target[0].code = #100c
* group.element[2].target[0].equivalence = #relatedto
* group.element[2].target[1].code = #100d
* group.element[2].target[1].equivalence = #relatedto
* group.element[3].code = #localized-fit-loss
* group.element[3].target[0].code = #100e
* group.element[3].target[0].equivalence = #relatedto
* group.element[4].code = #generalized-fit-loss
* group.element[4].target[0].code = #100f
* group.element[4].target[0].equivalence = #relatedto

Instance: ProstheticFindingToGozSuggestion
InstanceOf: ConceptMap
Usage: #definition
Title: "Prosthetic Device Finding to GOZ Suggestion"
Description: "Non-authoritative candidate mapping from technical prosthetic-device findings to GOZ positions. Clinical context and the performed service remain decisive."
* name = "ProstheticFindingToGozSuggestion"
* id = "prosthetic-finding-to-goz-suggestion"
* url = "https://fhir.cognovis.de/dental/ConceptMap/prosthetic-finding-to-goz-suggestion"
* status = #active
* experimental = false
* publisher = "cognovis GmbH"
* sourceCanonical = "https://fhir.cognovis.de/dental/ValueSet/prosthetic-device-finding"
* targetUri = "https://fhir.cognovis.de/dental/CodeSystem/goz"
* group.source = "https://fhir.cognovis.de/dental/CodeSystem/prosthetic-device-finding"
* group.target = "https://fhir.cognovis.de/dental/CodeSystem/goz"
* group.element[0].code = #base-fracture
* group.element[0].target[0].code = #5310
* group.element[0].target[0].equivalence = #relatedto
* group.element[1].code = #attachment-retention-loss
* group.element[1].target[0].code = #5250
* group.element[1].target[0].equivalence = #relatedto
* group.element[1].target[1].code = #5290
* group.element[1].target[1].equivalence = #relatedto
* group.element[2].code = #screw-loosening
* group.element[2].target[0].code = #9050
* group.element[2].target[0].equivalence = #relatedto
* group.element[2].target[1].code = #9060
* group.element[2].target[1].equivalence = #relatedto
* group.element[3].code = #crown-fracture
* group.element[3].target[0].code = #2200
* group.element[3].target[0].equivalence = #relatedto
