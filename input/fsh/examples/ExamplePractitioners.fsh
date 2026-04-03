// Beispiel-Behandler und -rollen aus den MIRA Seed-Daten

// ============================================================
// Practitioner 1: Dr. Martin Schöll (Zahnarzt)
// ============================================================
Instance: prac-schoell
InstanceOf: Practitioner
Usage: #example
Title: "Beispiel Zahnarzt Dr. Martin Schöll"
Description: "Dr. Martin Schöll, Zahnarzt, LANR 660100101."

* identifier[0].system = "http://fhir.de/sid/kbv/lanr"
* identifier[0].value = "660100101"
* active = true
* name[0].use = #official
* name[0].family = "Schöll"
* name[0].given[0] = "Martin"
* qualification[0].code.coding[0].system = "http://terminology.hl7.org/CodeSystem/v2-0360"
* qualification[0].code.coding[0].code = #MD
* qualification[0].code.coding[0].display = "Doctor of Medicine"
* qualification[0].code.text = "Zahnarzt"

// ============================================================
// Practitioner 2: Lena Uselmann (Zahnärztin)
// ============================================================
Instance: prac-uselmann
InstanceOf: Practitioner
Usage: #example
Title: "Beispiel Zahnärztin Lena Uselmann"
Description: "Lena Uselmann, Zahnärztin, LANR 660100105."

* identifier[0].system = "http://fhir.de/sid/kbv/lanr"
* identifier[0].value = "660100105"
* active = true
* name[0].use = #official
* name[0].family = "Uselmann"
* name[0].given[0] = "Lena"
* qualification[0].code.coding[0].system = "http://terminology.hl7.org/CodeSystem/v2-0360"
* qualification[0].code.coding[0].code = #MD
* qualification[0].code.coding[0].display = "Doctor of Medicine"
* qualification[0].code.text = "Zahnärztin"

// ============================================================
// PractitionerRole 1: Dr. Schöll @ Gibitzenhof (org-dental-mvz)
// ============================================================
Instance: role-schoell-gibitzenhof
InstanceOf: PractitionerRole
Usage: #example
Title: "Beispiel Zahnarztrolle Dr. Schöll (Gibitzenhof)"
Description: "Dr. Martin Schöll als Zahnarzt in der MIRA Demo-Zahnarztpraxis (MVZ)."

* active = true
* practitioner = Reference(Practitioner/prac-schoell)
* organization = Reference(Organization/org-dental-mvz)
* code[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/practitioner-role"
* code[0].coding[0].code = #doctor
* code[0].coding[0].display = "Doctor"
* specialty[0].text = "Zahnarzt"

// ============================================================
// PractitionerRole 2: Lena Uselmann @ Plärrер (org-dental-mvz)
// ============================================================
Instance: role-uselmann-plaerrer
InstanceOf: PractitionerRole
Usage: #example
Title: "Beispiel Zahnarztrolle Lena Uselmann (Plärrер)"
Description: "Lena Uselmann als Zahnärztin in der MIRA Demo-Zahnarztpraxis (MVZ)."

* active = true
* practitioner = Reference(Practitioner/prac-uselmann)
* organization = Reference(Organization/org-dental-mvz)
* code[0].coding[0].system = "http://terminology.hl7.org/CodeSystem/practitioner-role"
* code[0].coding[0].code = #doctor
* code[0].coding[0].display = "Doctor"
* specialty[0].text = "Zahnärztin"
