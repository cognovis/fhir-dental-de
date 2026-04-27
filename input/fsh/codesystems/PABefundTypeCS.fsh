CodeSystem: PABefundTypeCS
Id: pa-befund-type
Title: "PA-Befund Typ"
Description: "Observation type codes for periodontal assessments in pvs-charly. These codes identify the type of periodontal measurement recorded in an Observation (e.g. pocket depth, attachment loss, bleeding on probing, furcation involvement). Replaces the interim system https://pvs.charly.de/fhir/CodeSystem/pa-befund with an IG-conformant URL."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "cognovis GmbH"

* #pocket-depth "Taschentiefe" "Parodontale Taschentiefe in mm (Sondierungstiefe)"
* #attachment-loss "Attachmentverlust" "Klinischer Attachmentverlust in mm"
* #bleeding "Blutung on Probing" "Blutung nach Sondierung (BOP)"
* #furcation "Furkationsbeteiligung" "Furkationsgrad (0=keine, 1=Klasse I, 2=Klasse II, 3=Klasse III)"
