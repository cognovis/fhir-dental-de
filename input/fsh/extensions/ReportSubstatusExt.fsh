Extension: ReportSubstatusExt
Id: report-substatus
Title: "Report Substatus"
Description: "Erweiterter Substatus für Befundberichte, der den Bearbeitungsstand innerhalb des Befundworkflows beschreibt (z.B. Diktat ausstehend, diktiert, zur Unterzeichnung, unterzeichnet). Verwendet ReportSubstatusCS aus de.cognovis.fhir.praxis."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/report-substatus"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "DiagnosticReport"

* value[x] only code
* value[x] from ReportSubstatusVS (required)
* value[x] ^short = "Substatus: dictation-pending | dictated | read-pending | signed"
