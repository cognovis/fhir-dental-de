Alias: $sct = http://snomed.info/sct

Profile: OralHealthScreeningDE
Parent: DentalFindingDE
Id: oral-health-screening
Title: "Oral Health Screening (DE)"
Description: "Profil fuer ganzheitliche orale Gesundheitsbefunde: Parafunktionale Habits (Bruxismus, Zungenpressen, Wangenbeissen), orale Risikofaktoren (Raucherstatus, Xerostomie, Mundatmung), und Screening-Befunde fuer systemische Erkrankungen (orale Manifestationen). Spezialisierung von DentalFindingDE. Aligned with MedMij mz-ParafunctionalActivity (SNOMED 110353005) but extends beyond habits to cover oral risk factors and systemic screening."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// Code: must be from oral health screening codes
* code from OralHealthScreeningCodesVS (extensible)

// bodySite is optional (screening is typically whole-mouth)
* bodySite 0..1

// Components: structured screening findings
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component ^slicing.description = "Slicing for oral health screening components"

* component contains
    bruxism 0..1 MS and
    tongueThrust 0..1 MS and
    cheekBiting 0..1 MS and
    lipBiting 0..1 MS and
    mouthBreathing 0..1 MS and
    digitSucking 0..1 MS and
    onychophagia 0..1 MS and
    smokingStatus 0..1 MS and
    xerostomia 0..1 MS and
    oralManifestation 0..* MS

// --- Parafunctional Habits ---

// Bruxism: teeth grinding/clenching (present/absent + optional severity note)
* component[bruxism].code = $sct#25780007 "Bruxism"
* component[bruxism].value[x] only CodeableConcept or boolean
* component[bruxism].value[x] ^short = "Present/absent or coded severity"

// Tongue thrust: habitual tongue pressing against teeth
* component[tongueThrust].code = $sct#289147003 "Tongue thrust present"
* component[tongueThrust].value[x] only boolean
* component[tongueThrust].value[x] ^short = "Present (true) or absent (false)"

// Cheek biting: morsicatio buccarum
* component[cheekBiting].code = $sct#52709000 "Cheek biting"
* component[cheekBiting].value[x] only boolean

// Lip biting
* component[lipBiting].code = $sct#88616008 "Lip biting"
* component[lipBiting].value[x] only boolean

// Mouth breathing
* component[mouthBreathing].code = $sct#79688008 "Mouth breathing"
* component[mouthBreathing].value[x] only boolean

// Digit/thumb sucking (relevant for pediatric/KFO)
* component[digitSucking].code = $sct#26078007 "Thumb sucking"
* component[digitSucking].value[x] only boolean

// Nail biting (onychophagia)
* component[onychophagia].code = $sct#61891009 "Onychophagia"
* component[onychophagia].value[x] only boolean

// --- Oral Risk Factors ---

// Smoking status (uses standard SNOMED finding codes)
* component[smokingStatus].code = $sct#229819007 "Tobacco use and target"
* component[smokingStatus].value[x] only CodeableConcept
* component[smokingStatus].value[x] ^short = "Coded smoking status (current/former/never)"

// Xerostomia (dry mouth — medication side effect, Sjogren's, radiation)
* component[xerostomia].code = $sct#87715008 "Xerostomia"
* component[xerostomia].value[x] only CodeableConcept or boolean
* component[xerostomia].value[x] ^short = "Present/absent or coded severity"

// --- Systemic Screening via Oral Diagnostics ---

// Oral manifestation of systemic disease (repeatable — multiple findings possible)
* component[oralManifestation].code = $sct#128139000 "Inflammatory disorder of mouth"
* component[oralManifestation].value[x] only CodeableConcept
* component[oralManifestation].value[x] ^short = "Specific finding (e.g., oral candidiasis, lichen planus, diabetes-related periodontal changes)"
