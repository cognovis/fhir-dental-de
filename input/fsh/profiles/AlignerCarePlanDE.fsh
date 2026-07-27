Profile: AlignerCarePlanDE
Parent: DentalCarePlanDE
Id: aligner-care-plan
Title: "Aligner Care Plan (DE)"
Description: "KFO care plan with tooth-specific attachment and interproximal-reduction entries."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

* category[planType] = DentalCarePlanTypeCS#kfo
* extension contains
    AlignerAttachmentPlanExt named plannedAttachment 0..* MS and
    AlignerInterproximalReductionPlanExt named plannedReduction 0..* MS
