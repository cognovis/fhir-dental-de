// Beispielpatienten (Demo-Daten)
// Werden von anderen Beispiel-Instanzen referenziert

// ============================================================
// Patient 1: Klaus Bergmann (GKV, AOK Bayern)
// ============================================================
Instance: pat-gkv-01
InstanceOf: Patient
Usage: #example
Title: "Beispielpatient Klaus Bergmann (GKV)"
Description: "Klaus Bergmann, gesetzlich versichert (AOK Bayern), KVID A100100101. Nürnberg."

* identifier[0].type.coding[0].system = "http://fhir.de/CodeSystem/identifier-type-de-basis"
* identifier[0].type.coding[0].code = #KVZ10
* identifier[0].system = "http://fhir.de/sid/gkv/kvid-10"
* identifier[0].value = "A100100101"
* active = true
* name[0].use = #official
* name[0].family = "Bergmann"
* name[0].given[0] = "Klaus"
* birthDate = "1962-04-17"
* address[0].use = #home
* address[0].type = #both
* address[0].line[0] = "Südliche Fürther Str. 14"
* address[0].city = "Nürnberg"
* address[0].postalCode = "90429"
* address[0].country = "DE"

// ============================================================
// Patient 2: Charlotte von Hohenstein (PKV)
// ============================================================
Instance: pat-pkv-01
InstanceOf: Patient
Usage: #example
Title: "Beispielpatientin Charlotte von Hohenstein (PKV)"
Description: "Charlotte von Hohenstein, privat versichert, weiblich. Nürnberg."

* active = true
* name[0].use = #official
* name[0].family = "von Hohenstein"
* name[0].given[0] = "Charlotte"
* gender = #female
* birthDate = "1975-09-03"
* address[0].use = #home
* address[0].type = #both
* address[0].line[0] = "Lorenzer Platz 8"
* address[0].city = "Nürnberg"
* address[0].postalCode = "90402"
* address[0].country = "DE"

// ============================================================
// Patient 3: Friedrich Hartmann (Beihilfe)
// ============================================================
Instance: pat-beihilfe-01
InstanceOf: Patient
Usage: #example
Title: "Beispielpatient Friedrich Hartmann (Beihilfe)"
Description: "Friedrich Hartmann, Beihilfeberechtigter, männlich. Nürnberg."

* active = true
* name[0].use = #official
* name[0].family = "Hartmann"
* name[0].given[0] = "Friedrich"
* gender = #male
* birthDate = "1958-11-22"
* address[0].use = #home
* address[0].type = #both
* address[0].line[0] = "Burgschmietstr. 42"
* address[0].city = "Nürnberg"
* address[0].postalCode = "90419"
* address[0].country = "DE"

// ============================================================
// Patient 4: Aylin Özdemir (GKV, Barmer)
// ============================================================
Instance: pat-gkv-dental-01
InstanceOf: Patient
Usage: #example
Title: "Beispielpatientin Aylin Özdemir (GKV)"
Description: "Aylin Özdemir, gesetzlich versichert (Barmer), KVID B200200202. Nürnberg."

* identifier[0].type.coding[0].system = "http://fhir.de/CodeSystem/identifier-type-de-basis"
* identifier[0].type.coding[0].code = #KVZ10
* identifier[0].system = "http://fhir.de/sid/gkv/kvid-10"
* identifier[0].value = "B200200202"
* active = true
* name[0].use = #official
* name[0].family = "Özdemir"
* name[0].given[0] = "Aylin"
* birthDate = "1988-03-14"
* address[0].use = #home
* address[0].type = #both
* address[0].line[0] = "Rothenburger Str. 71"
* address[0].city = "Nürnberg"
* address[0].postalCode = "90443"
* address[0].country = "DE"
