// ValueSet: Strahlenschutz-relevante Abrechnungscodes (BEMA + GOZ)
// Umfasst alle BEMA- und GOZ-Codes, die fuer strahlenschutzrechtlich relevante
// zahnärztliche Röntgenleistungen abgerechnet werden. Wird im Kontext der
// Sidexis-LogicalName-Abrechnung (zahnrad Roentgen-Review) eingesetzt.

ValueSet: RadiationRelevantBillingCodeVS
Id: radiation-relevant-billing-codes
Title: "Strahlenschutz-relevante Abrechnungscodes"
Description: "BEMA- und GOZ-Abrechnungscodes fuer strahlenschutzrechtlich relevante zahnärztliche Roentgenleistungen (DVT, OPG, Schädelaufnahme, Intraorale Einzelaufnahme). Quellen: GOZ-Katalog (BZAEK), BEMA-Z (KZBV), Sidexis-LogicalName-Mapping."
* ^url = "https://fhir.cognovis.de/dental/ValueSet/radiation-relevant-billing-codes"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// BEMA Röntgen-Codes (GKV)
* http://fhir.de/CodeSystem/kzbv/bema#Ae5370
* http://fhir.de/CodeSystem/kzbv/bema#Ae935d
* http://fhir.de/CodeSystem/kzbv/bema#Ae934a
* http://fhir.de/CodeSystem/kzbv/bema#Ae925a

// GOZ/GOÄ Röntgen-Codes (PKV/Selbstzahler)
* http://fhir.de/CodeSystem/bzaek/goz#Ae5004
* http://fhir.de/CodeSystem/bzaek/goz#Ae5090
* http://fhir.de/CodeSystem/bzaek/goz#Ae5000
