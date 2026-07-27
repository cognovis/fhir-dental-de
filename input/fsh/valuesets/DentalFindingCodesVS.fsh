ValueSet: DentalFindingCodesVS
Id: dental-finding-codes
Title: "Kuratierte zahnärztliche Befundcodes"
Description: """
Kompakte, öffentlich verfügbare Auswahlliste häufiger zahnärztlicher Befunde.
Sie enthält ausschließlich SNOMED-CT-Identifikatoren ohne Anzeigetexte.

Die vollständige Validierungsmenge der SNOMED-CT-Referenzmenge General Dentistry
wird lizenzgeschützt im Paket de.cognovis.terminology.dental.snomed bereitgestellt.
Verbraucher referenzieren dafür die stabile kanonische URL
https://fhir.cognovis.de/terminology/ValueSet/snomed-refset-721144007; Paket- und
Terminologieversionen werden ausschließlich in der Build- und Laufzeitkonfiguration fixiert.
"""
* ^url = "https://fhir.cognovis.de/dental/ValueSet/dental-finding-codes"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Public artifacts intentionally carry SCTIDs only. Displays are resolved from
// the gated terminology package at runtime and must not be copied into this IG.
* $sct#80967001
* $sct#442551007
* $sct#80353004
* $sct#109600005
* $sct#66383009
* $sct#714482007
* $sct#109709002
* $sct#109710007
* $sct#718052004
* $sct#87715008
* $sct#274950005

// Additional SCTIDs used by the clinical observation profiles in this IG.
* $sct#364126007
* $sct#113192009
* $sct#89362005
* $sct#427936003
* $sct#109706009
* $sct#25780007
* $sct#128139000
* include codes from system DentalDepositTypeCS

Alias: $sct = http://snomed.info/sct
