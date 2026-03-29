Extension: ToothSurfacesExt
Id: tooth-surfaces
Title: "Zahnflächen"
Description: "Betroffene Zahnfläche. Diese Extension ist wiederholbar (0..*) um mehrere betroffene Flächen pro Zahn anzugeben (z.B. mesial + okklusal bei einer zweiflächigen Füllung). Kodierung: M=Mesial, D=Distal, O=Okklusal, I=Inzisal, B=Bukkal, V=Vestibulär, L=Lingual, P=Palatinal."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/tooth-surfaces"
* ^status = #draft
* ^experimental = true
* ^publisher = "cognovis GmbH"
// Contexts: ChargeItem (Leistungsabrechnung) and Observation (Zahnbefund) are the primary
// carriers of surface-level detail in the dental workflow.
// Condition and Procedure are intentionally excluded: they use bodySite for anatomical
// location, and surface granularity on those resources is rare; when needed it is
// represented via bodySite.extension rather than a top-level extension.
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"
* ^context[+].type = #element
* ^context[=].expression = "Observation"

* extension 0..0
* value[x] only CodeableConcept
* value[x] from ToothSurfacesVS (required)
* value[x] ^short = "Zahnfläche (M, D, O, I, B, V, L, P)"
