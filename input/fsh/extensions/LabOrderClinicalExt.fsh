// Klinische Extensions fuer zahntechnische Laborauftraege
// Ergaenzen DentalLabServiceRequestDE um medizinisch-klinische Inhalte
// jenseits der reinen Abrechnung (BEL II / beb'97).

Extension: RestorationTypeExt
Id: restoration-type
Title: "Restaurationstyp"
Description: "Typ der zahntechnischen Restauration (z.B. Krone, Bruecke, Prothese). Kann mehrfach angegeben werden bei kombinierter Versorgung."
Context: ServiceRequest
* value[x] only CodeableConcept
* valueCodeableConcept from RestorationTypeVS (extensible)

Extension: ToothColorVitaExt
Id: tooth-color-vita
Title: "Zahnfarbe (VITA Classical)"
Description: "Zahnfarbbestimmung nach VITA Classical Farbskala (A1-D4). Grundlage fuer die farbliche Gestaltung der Restauration durch das Dentallabor."
Context: ServiceRequest
* value[x] only CodeableConcept
* valueCodeableConcept from VitaClassicalVS (extensible)

Extension: MaterialSpecificationExt
Id: material-specification
Title: "Materialvorgabe"
Description: "Vom Zahnarzt vorgegebenes Material fuer die Restauration. Kann mehrfach angegeben werden (z.B. Geruest + Verblendung)."
Context: ServiceRequest
* value[x] only CodeableConcept
* valueCodeableConcept from DentalMaterialVS (extensible)

Extension: PreparationTypeExt
Id: preparation-type
Title: "Praaparationsform"
Description: "Art der Zahnpraeparation (Stumpfgestaltung). Relevant fuer die Gestaltung des Kronenrandes durch das Dentallabor."
Context: ServiceRequest
* value[x] only CodeableConcept
* valueCodeableConcept from PreparationTypeVS (extensible)

Extension: AntagonistSituationExt
Id: antagonist-situation
Title: "Antagonistensituation"
Description: "Beschreibung der Gegenkiefer-Situation (z.B. natuerliche Bezahnung, Totalprothese, Implantate). Beeinflusst Materialwahl und Okklusionsgestaltung."
Context: ServiceRequest
* value[x] only string

Extension: OcclusionConceptExt
Id: occlusion-concept
Title: "Okklusionskonzept"
Description: "Gewuenschtes Okklusionskonzept als Vorgabe fuer die funktionelle Gestaltung der Restauration."
Context: ServiceRequest
* value[x] only CodeableConcept
* valueCodeableConcept from OcclusionConceptVS (extensible)

Extension: ImplantAbutmentExt
Id: implant-abutment
Title: "Implantat-Abutment"
Description: "Angaben zum Implantatsystem und Abutment-Typ. Nur relevant bei implantatgetragenem Zahnersatz."
Context: ServiceRequest
* extension contains
    implantSystem 0..1 and
    abutmentType 0..1 and
    platformDiameter 0..1
* extension[implantSystem].value[x] only string
* extension[implantSystem] ^short = "Implantatsystem (Hersteller + System, z.B. 'Straumann BLT')"
* extension[abutmentType].value[x] only string
* extension[abutmentType] ^short = "Abutment-Typ (z.B. 'Titanklebebasis', 'Multi-Unit')"
* extension[platformDiameter].value[x] only decimal
* extension[platformDiameter] ^short = "Plattformdurchmesser in mm"
