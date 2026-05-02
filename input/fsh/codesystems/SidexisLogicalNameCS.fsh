// CodeSystem: Sidexis 4 LogicalName codes (interim/fragment)
// Source: Dentsply Sirona Sidexis 4 API, LogicalName field in imaging metadata.
// LogicalName codes follow the pattern <Family>.<Subtype>.<Variant>
// e.g. XRay3D.Volume.Standard, XRay2D.Extraoral.Panorama.Standard
// This is a fragment CodeSystem covering only the four radiation-relevant modalities
// used in the zahnrad Roentgen-Review billing mapping.
// KFO variants (e.g. XRay2D.Extraoral.Panorama.Kfo) are intentionally excluded —
// they follow a different billing pathway and are NOT in the ConceptMap.

CodeSystem: SidexisLogicalNameCS
Id: sidexis-logical-name
Title: "Sidexis 4 LogicalName Codes"
Description: "Interim-Fragment der Sidexis 4 LogicalName-Codes fuer radiologische Aufnahmetypen. LogicalName-Codes folgen dem Muster <Family>.<Subtype>.<Variant>. Nur die vier Strahlenschutz-relevanten Standardvarianten sind enthalten; KFO-Varianten sind explizit ausgeschlossen."
* ^url = "https://www.dentsplysirona.com/sidexis/logical-name"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (Vorschlag)"
