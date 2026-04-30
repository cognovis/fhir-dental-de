CodeSystem: PABefundTypeCS
Id: pa-befund-type
Title: "PA-Befund Typ"
Description: "Component type codes for periodontal Observations. PA findings are stored as per-tooth strings with multi-digit measurements (e.g. '__0450__64' encodes [0,4,5,0,6,4] mm). These codes identify each component type. Replaces the interim system https://fhir.cognovis.de/dental/CodeSystem/pa-befund-interim with an IG-conformant URL."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/pa-befund-type"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "cognovis GmbH"

// String-kodiertes Format: '__0450__64' → [0,4,5,0,6,4] mm pro Messpunkt
* #pocket-depth-encoded "Taschentiefe (String-kodiert)" "Sondierungstiefen als String-kodierte Messung pro Zahn — mehrzifferige Kodierung, z.B. '__0450__64' = [0,4,5,0,6,4] mm"
* #attachment-loss "Attachmentverlust" "Klinischer Attachmentverlust in mm"
* #bleeding-on-probing "Blutung on Probing" "Blutung nach Sondierung (BOP)"
* #furcation "Furkationsbeteiligung" "Furkationsgrad (0=keine, 1=Klasse I, 2=Klasse II, 3=Klasse III)"
