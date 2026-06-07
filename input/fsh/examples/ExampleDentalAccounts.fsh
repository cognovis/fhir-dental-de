// Dental billing-case Accounts: reuse AccountPraxisSchein from the Praxis-DE IG.
// ScheinNummer, Scheinart (gkv/pkv), servicePeriod, and coverage live on Account — not Encounter.

Alias: $scheinartCS = https://fhir.cognovis.de/praxis/CodeSystem/scheinart

// ============================================================
// Coverage for Klaus Bergmann (GKV) and Charlotte von Hohenstein (PKV)
// ============================================================
Instance: cov-gkv-01-aok
InstanceOf: Coverage
Usage: #example
Title: "Beispiel GKV-Versicherung Klaus Bergmann (AOK Bayern)"
Description: "GKV Coverage für AccountPraxisSchein enc-dental-01."

* status = #active
* type.coding[0].system = "http://fhir.de/CodeSystem/versicherungsart-de-basis"
* type.coding[0].code = #GKV
* type.coding[0].display = "Gesetzliche Krankenversicherung"
* subscriber = Reference(Patient/pat-gkv-01)
* beneficiary = Reference(Patient/pat-gkv-01)
* payor[0].identifier.system = "http://fhir.de/sid/arge-ik/iknr"
* payor[0].identifier.value = "108310400"
* payor[0].display = "AOK Bayern"
* period.start = "2020-01-01"

Instance: cov-pkv-01-dkv
InstanceOf: Coverage
Usage: #example
Title: "Beispiel PKV-Versicherung Charlotte von Hohenstein (DKV)"
Description: "PKV Coverage für AccountPraxisSchein enc-dental-02."

* status = #active
* type.coding[0].system = "http://fhir.de/CodeSystem/versicherungsart-de-basis"
* type.coding[0].code = #PKV
* type.coding[0].display = "Private Krankenversicherung"
* subscriber = Reference(Patient/pat-pkv-01)
* beneficiary = Reference(Patient/pat-pkv-01)
* payor[0].display = "DKV Deutsche Krankenversicherung"
* period.start = "2018-06-01"

// ============================================================
// Account: GKV Schein Q1/2026 — Klaus Bergmann (BEMA/KZBV)
// ============================================================
Instance: acct-dental-01-gkv-q1
InstanceOf: AccountPraxisSchein
Usage: #example
Title: "Beispiel GKV-Schein Q1/2026 Klaus Bergmann"
Description: "Abrechnungs-Schein für GKV-Behandlungen Q1/2026. Verknüpft mit enc-dental-01-kassenschein via Encounter.account."

* status = #active
* type = $scheinartCS#gkv "GKV"
* identifier[scheinNummer].system = "https://fhir.cognovis.de/praxis/sid/scheinNummer"
* identifier[scheinNummer].value = "GKV-2026-Q1-00001"
* servicePeriod.start = "2026-01-01"
* servicePeriod.end = "2026-03-31"
* coverage[0].coverage = Reference(cov-gkv-01-aok)
* subject = Reference(Patient/pat-gkv-01)

// ============================================================
// Account: PKV Schein Q1/2026 — Charlotte von Hohenstein (GOZ)
// ============================================================
Instance: acct-dental-02-pkv-q1
InstanceOf: AccountPraxisSchein
Usage: #example
Title: "Beispiel PKV-Schein Q1/2026 Charlotte von Hohenstein"
Description: "Abrechnungs-Schein für Privatbehandlungen Q1/2026. Verknüpft mit enc-dental-02-privatschein."

* status = #active
* type = $scheinartCS#pkv "PKV"
* identifier[scheinNummer].system = "https://fhir.cognovis.de/praxis/sid/scheinNummer"
* identifier[scheinNummer].value = "PKV-2026-Q1-00002"
* servicePeriod.start = "2026-01-01"
* servicePeriod.end = "2026-03-31"
* coverage[0].coverage = Reference(cov-pkv-01-dkv)
* subject = Reference(Patient/pat-pkv-01)

// ============================================================
// Account: GKV Schein Q1/2026 — Aylin Özdemir (ZE)
// ============================================================
Instance: acct-dental-04-gkv-q1
InstanceOf: AccountPraxisSchein
Usage: #example
Title: "Beispiel GKV-Schein Q1/2026 Aylin Özdemir (ZE)"
Description: "Abrechnungs-Schein für ZE-Behandlung Q1/2026. Verknüpft mit enc-dental-04-ze-kassenschein."

* status = #active
* type = $scheinartCS#gkv "GKV"
* identifier[scheinNummer].system = "https://fhir.cognovis.de/praxis/sid/scheinNummer"
* identifier[scheinNummer].value = "GKV-2026-Q1-00004"
* servicePeriod.start = "2026-01-01"
* servicePeriod.end = "2026-03-31"
* coverage[0].coverage = Reference(cov-gkv-dental-01-gkv)
* subject = Reference(Patient/pat-gkv-dental-01)
