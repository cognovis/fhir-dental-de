Profile: GozInvoiceDE
Parent: DiPagRechnung
Id: goz-invoice-de
Title: "GOZ Invoice (DE)"
Description: "Dental private invoice profile for GOZ services. The profile specializes the official gematik DiPagRechnung contract without redefining its financial semantics."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* account 1..1 MS
* account only Reference(AccountPraxisSchein)
* account ^short = "Private dental billing account"

* lineItem 1..* MS
* lineItem.chargeItem[x] only Reference(GozChargeItemDE)
* lineItem.chargeItem[x] ^short = "GOZ service position carrying the section 10 invoice data"
