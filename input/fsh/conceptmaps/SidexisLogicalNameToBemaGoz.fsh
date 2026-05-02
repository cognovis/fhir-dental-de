// ConceptMap: Sidexis LogicalName → BEMA + GOZ Abrechnungscodes
// Bildet Sidexis 4 LogicalName-Aufnahmetypen auf GKV-BEMA- und GOZ-Privatpositionen ab.
//
// Mapping:
//   XRay3D.Volume.Standard             → DVT      → BEMA #Ae5370 (equivalent); GOZ #Ae5370 (related)
//                                                  comment: "related Ae935d/Ae5004 when DvtAcceptsOpg"
//   XRay2D.Extraoral.Panorama.Standard → OPG      → BEMA #Ae935d (equivalent); GOZ #Ae5004 (equivalent)
//   XRay2D.Extraoral.Ceph.Standard     → SCHAEDEL → BEMA #Ae934a (equivalent); GOZ #Ae5090 (equivalent)
//   XRay2D.Intraoral.Standard          → EINZEL   → BEMA #Ae925a (equivalent); GOZ #Ae5000 (equivalent)
//
// KFO variants (e.g. XRay2D.Extraoral.Panorama.Kfo → Ae935d-kfo) are intentionally NOT included —
// they follow a separate KFO billing pathway with different approval requirements.
//
// Purpose/Sources: GOZ-Katalog (BZAEK), BEMA-Z (KZBV),
//   zahnrad/tools/Roentgen-Review/README.md (Praxis-Validierung),
//   polaris-7os (Strahlen-Code-Whitelist)

Instance: SidexisLogicalNameToBemaGoz
InstanceOf: ConceptMap
Usage: #definition
Title: "Sidexis LogicalName → BEMA + GOZ Vorschlag"
Description: "Mapping von Sidexis 4 LogicalName-Aufnahmetypen auf GKV-BEMA- und GOZ-Privatpositionen fuer die zahnraedliche Roentgen-Review-Abrechnung. Quellen: GOZ-Katalog (BZAEK), BEMA-Z (KZBV), zahnrad/tools/Roentgen-Review/README.md (Praxis-Validierung), polaris-7os (Strahlen-Code-Whitelist)."

* name = "SidexisLogicalNameToBemaGozCM"
* url = "https://fhir.cognovis.de/dental/ConceptMap/sidexis-logical-name-to-bema-goz"
* status = #active
* experimental = false
* publisher = "cognovis GmbH"
* purpose = "GOZ-Katalog (BZAEK), BEMA-Z (KZBV), zahnrad/tools/Roentgen-Review/README.md (Praxis-Validierung), polaris-7os (Strahlen-Code-Whitelist)"
* sourceCanonical = "https://www.dentsplysirona.com/sidexis/logical-name"
* targetCanonical = "http://fhir.de/CodeSystem/kzbv/bema"

// Group 0: Sidexis LogicalName → BEMA
* group[0].source = "https://www.dentsplysirona.com/sidexis/logical-name"
* group[0].target = "http://fhir.de/CodeSystem/kzbv/bema"

// XRay3D.Volume.Standard → BEMA Ae5370 (DVT)
* group[0].element[0].code = #"XRay3D.Volume.Standard"
* group[0].element[0].display = "DVT (Digitale Volumentomographie)"
* group[0].element[0].target[0].code = #Ae5370
* group[0].element[0].target[0].display = "BEMA-Ae5370 (Digitale Volumentomographie)"
* group[0].element[0].target[0].equivalence = #equivalent

// XRay2D.Extraoral.Panorama.Standard → BEMA Ae935d (OPG)
* group[0].element[1].code = #"XRay2D.Extraoral.Panorama.Standard"
* group[0].element[1].display = "OPG (Panoramaschichtaufnahme)"
* group[0].element[1].target[0].code = #Ae935d
* group[0].element[1].target[0].display = "BEMA-Ae935d (Panoramaschichtaufnahme/OPG)"
* group[0].element[1].target[0].equivalence = #equivalent

// XRay2D.Extraoral.Ceph.Standard → BEMA Ae934a (Schädelaufnahme/FRS)
* group[0].element[2].code = #"XRay2D.Extraoral.Ceph.Standard"
* group[0].element[2].display = "Schaedelaufnahme (Fernroentgenaufnahme des Schadels)"
* group[0].element[2].target[0].code = #Ae934a
* group[0].element[2].target[0].display = "BEMA-Ae934a (Fernroentgenaufnahme Schadel)"
* group[0].element[2].target[0].equivalence = #equivalent

// XRay2D.Intraoral.Standard → BEMA Ae925a (Intraorale Einzelzahnaufnahme)
* group[0].element[3].code = #"XRay2D.Intraoral.Standard"
* group[0].element[3].display = "Intraoral (Einzelzahnaufnahme)"
* group[0].element[3].target[0].code = #Ae925a
* group[0].element[3].target[0].display = "BEMA-Ae925a (Intraorale Einzelzahnaufnahme)"
* group[0].element[3].target[0].equivalence = #equivalent

// Group 1: Sidexis LogicalName → GOZ
* group[1].source = "https://www.dentsplysirona.com/sidexis/logical-name"
* group[1].target = "http://fhir.de/CodeSystem/bzaek/goz"

// XRay3D.Volume.Standard → GOZ Ae5370 (DVT) — related because Ae935d/Ae5004 may apply when DvtAcceptsOpg
* group[1].element[0].code = #"XRay3D.Volume.Standard"
* group[1].element[0].display = "DVT (Digitale Volumentomographie)"
* group[1].element[0].target[0].code = #Ae5370
* group[1].element[0].target[0].display = "GOZ/GOÄ-Ae5370 (Digitale Volumentomographie/DVT)"
* group[1].element[0].target[0].equivalence = #relatedto
* group[1].element[0].target[0].comment = "related Ae935d/Ae5004 when DvtAcceptsOpg"

// XRay2D.Extraoral.Panorama.Standard → GOZ Ae5004 (OPG)
* group[1].element[1].code = #"XRay2D.Extraoral.Panorama.Standard"
* group[1].element[1].display = "OPG (Panoramaschichtaufnahme)"
* group[1].element[1].target[0].code = #Ae5004
* group[1].element[1].target[0].display = "GOZ/GOÄ-Ae5004 (Panoramaschichtaufnahme/OPG)"
* group[1].element[1].target[0].equivalence = #equivalent

// XRay2D.Extraoral.Ceph.Standard → GOZ Ae5090 (Schädelaufnahme/FRS)
* group[1].element[2].code = #"XRay2D.Extraoral.Ceph.Standard"
* group[1].element[2].display = "Schaedelaufnahme (Fernroentgenaufnahme des Schadels)"
* group[1].element[2].target[0].code = #Ae5090
* group[1].element[2].target[0].display = "GOZ/GOÄ-Ae5090 (Fernroentgenaufnahme des Schadels)"
* group[1].element[2].target[0].equivalence = #equivalent

// XRay2D.Intraoral.Standard → GOZ Ae5000 (Intraorale Röntgenaufnahme)
* group[1].element[3].code = #"XRay2D.Intraoral.Standard"
* group[1].element[3].display = "Intraoral (Einzelzahnaufnahme)"
* group[1].element[3].target[0].code = #Ae5000
* group[1].element[3].target[0].display = "GOZ/GOÄ-Ae5000 (Intraorale Roentgenaufnahme)"
* group[1].element[3].target[0].equivalence = #equivalent
