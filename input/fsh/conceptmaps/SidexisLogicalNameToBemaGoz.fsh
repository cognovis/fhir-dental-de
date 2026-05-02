// ConceptMap: Sidexis LogicalName → BEMA + GOZ Abrechnungscodes
// Bildet Sidexis 4 LogicalName-Aufnahmetypen auf GKV-BEMA- und GOZ-Privatpositionen ab.
// Quellen: GOZ-Katalog (BZAEK), BEMA-Z (KZBV), zahnrad/tools/Roentgen-Review/README.md
//          (Praxis-Validierung), polaris-7os (Strahlen-Code-Whitelist)
//
// Mapping:
//   XRay3D.Volume.Standard          → DVT     → BEMA #Ae5370 (equivalent); GOZ #Ae5370 (related)
//                                              comment: "related Ae935d/Ae5004 when DvtAcceptsOpg"
//   XRay2D.Extraoral.Panorama.Standard → OPG  → BEMA #Ae935d (equivalent); GOZ #Ae5004 (equivalent)
//   XRay2D.Extraoral.Ceph.Standard   → SCHAEDEL → BEMA #Ae934a (equivalent); GOZ #Ae5090 (equivalent)
//   XRay2D.Intraoral.Standard        → EINZEL → BEMA #Ae925a (equivalent); GOZ #Ae5000 (equivalent)
//
// KFO variants (e.g. XRay2D.Extraoral.Panorama.Kfo → Ae935d-kfo) are intentionally NOT included —
// they follow a separate KFO billing pathway with different approval requirements.

Instance: SidexisLogicalNameToBemaGoz
InstanceOf: ConceptMap
Usage: #definition
Title: "Sidexis LogicalName → BEMA + GOZ Vorschlag"
Description: "Stub - TODO: complete"

* name = "SidexisLogicalNameToBemaGozCM"
* url = "https://fhir.cognovis.de/dental/ConceptMap/sidexis-logical-name-to-bema-goz"
* status = #active
* experimental = false
* publisher = "cognovis GmbH"
