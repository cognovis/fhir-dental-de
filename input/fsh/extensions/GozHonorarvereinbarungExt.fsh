Extension: GozHonorarvereinbarungExt
Id: goz-honorarvereinbarung
Title: "GOZ-Honorarvereinbarung nach § 2 Abs. 1 und 2"
Description: "Evidence for a written, case-specific GOZ fee agreement made before the service. The referenced document remains the authority for personal discussion, signatures, copy handover, service details, and the reimbursement warning."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/goz-honorarvereinbarung"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "ChargeItem"

* extension contains
    document 1..1 MS and
    agreedOn 1..1 MS and
    agreedAmount 1..1 MS and
    reimbursementNoticeGiven 1..1 MS

* extension[document].value[x] only Reference(DocumentReference)
* extension[document].valueReference ^short = "Written GOZ §2(1)-(2) agreement"

* extension[agreedOn].value[x] only date
* extension[agreedOn].valueDate ^short = "Date on which the agreement was made"

* extension[agreedAmount].value[x] only Money
* extension[agreedAmount].valueMoney ^short = "Resulting amount agreed for this service"

* extension[reimbursementNoticeGiven].value[x] only boolean
* extension[reimbursementNoticeGiven].valueBoolean = true
* extension[reimbursementNoticeGiven].valueBoolean ^short = "The document states that reimbursement may not be complete"

* obeys goz-agreement-eur

Invariant: goz-agreement-eur
Description: "The agreed amount uses EUR."
Severity: #error
Expression: "extension.where(url='agreedAmount').valueMoney.currency = 'EUR'"
