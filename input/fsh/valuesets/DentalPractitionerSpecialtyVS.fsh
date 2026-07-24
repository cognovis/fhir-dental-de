// Dental PractitionerRole.specialty — SNOMED CT only (ADR-009 / License Class I).
// Public IG carries SCTID + system references only; no embedded SNOMED display text.
// Runtime displays/validation: de.cognovis.terminology.dental.snomed@1.2.0
ValueSet: DentalPractitionerSpecialtyVS
Id: dental-practitioner-specialty
Title: "Dental Practitioner Specialty (SNOMED CT)"
Description: """Initial dental specialty concepts for PractitionerRole.specialty, coded in SNOMED CT (http://snomed.info/sct).
This IG does not define a local dental specialty CodeSystem while SNOMED CT covers these concepts.
Public artifacts reference SCTIDs only; German/English displays come from the gated terminology package de.cognovis.terminology.dental.snomed."""
* ^url = "https://fhir.cognovis.de/dental/ValueSet/dental-practitioner-specialty"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^copyright = """This value set includes SNOMED CT® concept references under the IHTSDO Affiliate License (Affiliate No. 1636879).
This public IG carries SNOMED CT identifiers and system URIs only; full concept content (including displays) is distributed via the authenticated package de.cognovis.terminology.dental.snomed.
SNOMED CT® is a registered trademark of the International Health Terminology Standards Development Organisation (IHTSDO)."""

// Pilot specialty concepts available in de.cognovis.terminology.dental.snomed@1.2.0
// Do not include removed/invalid concepts 408462000 or 27568000.
* $sct#106289002
* $sct#394812008
* $sct#408444009
* $sct#408460008
* $sct#408461007
* $sct#408465003
