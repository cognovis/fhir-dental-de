Extension: ToothSurfacesExt
Id: tooth-surfaces
Title: "Zahnflächen"
Description: "Betroffene Zahnfläche. Diese Extension ist wiederholbar (0..*) um mehrere betroffene Flächen pro Zahn anzugeben (z.B. mesial + okklusal bei einer zweiflächigen Füllung). Die Kodierung verwendet das HL7 Terminology CodeSystem FDI-surface."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
// ChargeItem and Observation are primary carriers of surface-level detail.
// Condition is allowed only on bodySite so every surface remains attached to
// the tooth identity represented by that CodeableConcept.
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"
* ^context[+].type = #element
* ^context[=].expression = "Observation"
* ^context[+].type = #element
* ^context[=].expression = "Observation.bodySite"
* ^context[+].type = #element
* ^context[=].expression = "Condition.bodySite"

* extension 0..0
* value[x] only CodeableConcept
* value[x] from ToothSurfacesVS (required)
* value[x] ^short = "Zahnfläche nach HL7 Terminology FDI-surface"
