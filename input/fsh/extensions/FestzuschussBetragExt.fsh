Extension: FestzuschussBetragExt
Id: festzuschuss-betrag
Title: "Versionierter Festzuschuss-Betrag"
Description: "Applied subsidy amount for one Festzuschuss finding, benefit percentage, and effective period. Public examples use synthetic amounts; production values require a current, separately governed source dataset."
* ^url = "https://fhir.cognovis.de/dental/StructureDefinition/festzuschuss-betrag"
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"
* ^context[+].type = #element
* ^context[=].expression = "Claim.item"

* extension contains
    finding 1..1 MS and
    benefitPercentage 1..1 MS and
    amount 1..1 MS and
    effectivePeriod 1..1 MS and
    source 1..1 MS

* extension[finding].value[x] only Coding
* extension[finding].valueCoding.system = "https://fhir.cognovis.de/dental/CodeSystem/festzuschuss-befund"
* extension[finding].valueCoding ^short = "Festzuschuss finding code"

* extension[benefitPercentage].value[x] only positiveInt
* extension[benefitPercentage].valuePositiveInt ^short = "Applied legal benefit percentage: 60, 70, 75, or at most 100 for hardship"

* extension[amount].value[x] only Money
* extension[amount].valueMoney ^short = "Applied subsidy amount in EUR"

* extension[effectivePeriod].value[x] only Period
* extension[effectivePeriod].valuePeriod ^short = "Closed period for which the amount is applicable"

* extension[source].value[x] only uri
* extension[source].valueUri ^short = "Exact source edition for the amount dataset"

* obeys fz-benefit-percentage and fz-amount-eur and fz-effective-period

Invariant: fz-benefit-percentage
Description: "The benefit percentage is one of the statutory standard, five-year, ten-year, or maximum hardship levels."
Severity: #error
Expression: "extension.where(url='benefitPercentage').valuePositiveInt = 60 or extension.where(url='benefitPercentage').valuePositiveInt = 70 or extension.where(url='benefitPercentage').valuePositiveInt = 75 or extension.where(url='benefitPercentage').valuePositiveInt = 100"

Invariant: fz-amount-eur
Description: "The subsidy amount uses EUR."
Severity: #error
Expression: "extension.where(url='amount').valueMoney.currency = 'EUR'"

Invariant: fz-effective-period
Description: "The amount has a complete, ordered effective period."
Severity: #error
Expression: "extension.where(url='effectivePeriod').valuePeriod.where(start.exists() and end.exists() and start < end).exists()"
