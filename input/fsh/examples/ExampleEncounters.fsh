// Beispiel-Behandlungskontakte (Demo-Daten, ADR-039)
// Klinischer Kontakt = DentalEncounterDE; Abrechnungs-Schein = AccountPraxisSchein via Encounter.account

Alias: $v3-act-code = http://terminology.hl7.org/CodeSystem/v3-ActCode

// ============================================================
// Encounter 1: GKV Kassenschein 2026-01-10, Klaus Bergmann
// ============================================================
Instance: enc-dental-01-kassenschein
InstanceOf: DentalEncounterDE
Usage: #example
Title: "Beispiel Behandlungskontakt GKV 2026-01-10 (enc-dental-01)"
Description: "Klinischer Behandlungskontakt am 2026-01-10 für Klaus Bergmann. Abrechnungs-Schein via account → acct-dental-01-gkv-q1 (GKV Q1/2026)."

* identifier[0].system = "https://example-dental-practice.de/fall-id"
* identifier[0].value = "DENTAL-2026-0001"

* status = #finished

* class = $v3-act-code#AMB "ambulatory"

* subject = Reference(Patient/pat-gkv-01)

* participant[0].individual = Reference(PractitionerRole/role-schoell-gibitzenhof)

* period.start = "2026-01-10"
* period.end = "2026-01-10"

* account[0] = Reference(acct-dental-01-gkv-q1)

// ============================================================
// Encounter 2: Privatschein 2026-01-22, Charlotte von Hohenstein
// ============================================================
Instance: enc-dental-02-privatschein
InstanceOf: DentalEncounterDE
Usage: #example
Title: "Beispiel Behandlungskontakt PKV 2026-01-22 (enc-dental-02)"
Description: "Klinischer Behandlungskontakt am 2026-01-22 für Charlotte von Hohenstein. Abrechnungs-Schein via account → acct-dental-02-pkv-q1 (PKV Q1/2026)."

* identifier[0].system = "https://example-dental-practice.de/fall-id"
* identifier[0].value = "DENTAL-2026-0002"

* status = #finished

* class = $v3-act-code#AMB "ambulatory"

* subject = Reference(Patient/pat-pkv-01)

* participant[0].individual = Reference(PractitionerRole/role-uselmann-plaerrer)

* period.start = "2026-01-22"
* period.end = "2026-01-22"

* account[0] = Reference(acct-dental-02-pkv-q1)

// ============================================================
// Encounter 3: ZE Kassenschein, Aylin Özdemir
// ============================================================
Instance: enc-dental-04-ze-kassenschein
InstanceOf: DentalEncounterDE
Usage: #example
Title: "Beispiel Behandlungskontakt ZE Aylin Özdemir (enc-dental-04)"
Description: "Klinischer Behandlungskontakt ab 2026-01-15 für Aylin Özdemir. Abrechnungs-Schein via account → acct-dental-04-gkv-q1."

* identifier[0].system = "https://example-dental-practice.de/fall-id"
* identifier[0].value = "DENTAL-2026-0004"

* status = #in-progress

* class = $v3-act-code#AMB "ambulatory"

* subject = Reference(Patient/pat-gkv-dental-01)

* participant[0].individual = Reference(PractitionerRole/role-schoell-gibitzenhof)

* period.start = "2026-01-15"

* account[0] = Reference(acct-dental-04-gkv-q1)
