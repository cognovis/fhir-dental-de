# Changelog

All notable changes to this project will be documented in this file.

## [0.34.0] - 2026-05-12

### Features

- **fdde-8vf**: USt-Modellierung in dental ChargeItems via praxis@0.61.0 Tax-Pattern
  - `BemaChargeItemDE`: TaxCategoryExt fix=`E` (steuerfrei) + TaxExemptionReasonExt fix=`para4-nr14a` (§ 4 Nr. 14a UStG — BEMA = GKV-Heilbehandlung)
  - `GozChargeItemDE`: TaxCategoryExt + TaxExemptionReasonExt als MS mit zwei Invarianten
    - `goz-tax-iff-e` (bi-direktional): TaxExemptionReason vorhanden wenn-und-nur-wenn TaxCategory=E
    - `goz-tax-verlangens-s` (Trigger): VerlangensleistungExt=true → TaxCategory MUSS S sein
  - Neues Sub-Profil `GozZahntechWerkstueckChargeItemDE` für Eigenlabor-Werkstücke: TaxCategory fix=`AA` (7% nach § 12 Abs. 2 Nr. 6 UStG / Anlage 2 Nr. 52), TaxExemptionReason 0..0 verboten
  - Vier komplette Beispielinstanzen aktualisiert/neu: BEMA 13c (E+para4-nr14a), GOZ 2150 Aufbaufüllung (E+para4-nr14a), GOZ Bleaching Verlangens (S, kein Befreiungsgrund), GOZ 2200 Vollkeramik-Krone Eigenlabor (AA, kein Befreiungsgrund)

### Documentation

- **fdde-8vf**: Neue pagecontent `ust-modellierung.md` — steuerrechtliche Grundlagen, Modellierung via praxis-de Extensions, profil-spezifische Pattern (BEMA fix / GOZ Invarianten / Eigenlabor Sub-Profil), Ausblick auf ZE-Mischrechnung
- **fdde-8vf**: Aliases `$TaxCategoryExt`, `$TaxExemptionReasonExt`, `$UnCefact5305`, `$UStBefreiungsgrundCS` in `input/fsh/aliases.fsh` zentral hinterlegt

## [0.33.0] - 2026-05-12

### Features

- **fdde-0pf**: Verlangensleistung nach § 1 Abs. 2 Satz 2 GOZ als Extension markierbar
  - Neue `VerlangensleistungExt` Extension auf ChargeItem mit `verlangensleistung` (boolean) und optionaler `verlangensleistungBeleg` (Reference DocumentReference)
  - Eingebunden in `GozChargeItemDE` als optionale Extension `verlangensleistung 0..1 MS`
  - Neuer informativer `TypischeVerlangensleistungenCS` / `VS` mit 8 typischen Verlangens-Codes (Bleaching, Veneer-aesthetic, ästhetischer Aufschlag, Schmuckstein, PZR-ästhetisch etc.)
  - Beispielinstanz `ExampleGozChargeItemVerlangens` (Bleaching, Faktor 2,3, mit Beleg-Reference)

### Documentation

- **fdde-0pf**: Neue pagecontent `verlangensleistung.md` — Abgrenzung Heilbehandlung vs Verlangensleistung, gebühren- und steuerrechtliche Konsequenzen, Modellierung im IG, Indikations-Prüfung, Beweissicherung

## [0.32.0] - 2026-05-12

### Features

- **fdde-n4q**: Migrate BemaChargeItemDE + GozChargeItemDE to `ChargeItemPraxisDe` parent (3-Layer-Chain pre-step for fdde-8vf)
  - BemaChargeItemDE: Parent changed from `ChargeItem` to `ChargeItemPraxisDe`
  - GozChargeItemDE: Parent changed from `ChargeItem` to `ChargeItemPraxisDe`
  - Both profiles now inherit `TaxCategoryExt` and `TaxExemptionReasonExt` from praxis@0.61.0 — concrete tax-pattern application happens in fdde-8vf

### Documentation

- **fdde-n4q**: Tax-Pattern comments updated in BemaChargeItemDE.fsh + GozChargeItemDE.fsh — clarify which tax extensions are now available via inheritance and which use cases (Heilbehandlung E + para4-nr14a, Verlangens S, Eigenlabor AA) fdde-8vf will model
- **fdde-n4q**: architecture-profile-audit.md rewritten — corrects factual claims about which praxis@0.61.0 wrappers exist (PraxisCarePlanDE, EncounterPraxis, ChargeItemPraxisDe, ImagingStudyPraxisDe, ImagingDiagnosticReportPraxisDe etc. are all present); classifies non-migrated profiles into "wrapper available — deferred", "wrapper exists but wrong fit", "no wrapper exists"

## [0.31.0] - 2026-05-12

### Features

- **fdde-pax.2**: Migrate DentalConditionDE + DentalOrganizationDE to Praxis*DE parents (3-Layer-Chain KBV→praxis-de→dental-de)
  - DentalConditionDE: Parent changed from `Condition` to `PraxisConditionDE`
  - DentalOrganizationDE: Parent changed from `Organization` to `PraxisOrganizationDE`; identifier slicing reworked to be compatible with KBV_PR_Base_Organization (type=value, path=type discriminator); BSNR now inherited as `identifier:Betriebsstaettennummer`; KZV-Stempelnummer uses inherited `identifier:KZV-Abrechnungsnummer`
  - praxis-de dependency bumped 0.48.0 → 0.61.0

### Documentation

- **fdde-pax.2**: Add architecture-profile-audit.md documenting 3-Layer-Chain pattern and why 10 dental profiles are NOT migrated (no matching Praxis*DE wrappers in praxis-de v0.61.0)
- **fdde-pax.2**: Add Tax-Pattern doc comments to BemaChargeItemDE.fsh and GozChargeItemDE.fsh (§ 19 UStG / Abfärbung / ZE Mischrechnung — for future evaluation, no implementation)
- **fdde-pax.2**: DentalConditionDE top-comment rewritten: explains 3-Layer-Chain, KZBV gap, and reusability path

## [0.30.0] - 2026-05-04

### Features

- Bump de.cognovis.fhir.praxis dependency to 0.48.0 (adds PraxisComposition, PraxisCommunication, PraxisFlag, PraxisMedicationAdministration, PraxisAnamneseQuestionnaireResponse, PraxisImmunization with KBV-MIO-Impfpass vocabulary)

## [unreleased]

### Bug Fixes

- **fdde-4qi**: Fix ig-release.yml missing private FHIR package pre-load; unblocks releases from v0.26.0+ (all green on CI run 25279193047, de.cognovis.fhir.dental@0.29.1 live on npm.cognovis.de)
- **fdde-wzv**: Add copyright-allowlist markers to BemaCS display texts
- **fdde-o84**: Correct BEMA-Z mapping numbers from official 2026 catalog

### Documentation

- **fdde-o84**: Add BEMA-Z mapping hints to BemaCS surgical code comments for clarity
- **fdde-a5j**: Document pre-push copyright hook setup in CLAUDE.md

### Miscellaneous

- **fdde-9ah**: Extract private FHIR package preload into composite GitHub Action; replace 38-line duplicated inline step in ig-ci.yml and ig-release.yml with 3-line uses: reference (76 lines removed, structural parity enforced)
- **deps**: Bump de.cognovis.fhir.praxis to 0.45.1
- **fdde-a5j**: Add changelog entry for pre-push copyright hook documentation

### Refactoring

- **fdde-o84**: Expand BemaCS surgical codes comment with BEMA-Z mapping hints

### Merge

- Resolve CHANGELOG conflict from concurrent worktree sessions
- Worktree-bead-fdde-511

## [0.28.0] - 2026-05-02

### Miscellaneous

- Bump version to 0.28.0

### Merge

- Origin/main into worktree-bead-fdde-fi9 (resolve CHANGELOG conflict)
- Worktree-bead-fdde-fi9

## [0.27.1] - 2026-05-02

### Bug Fixes

- **ci**: Vendor de.cognovis.terminology.imaging for CI FHIR cache
- **ci**: Fetch terminology.imaging from Verdaccio with VERDACCIO_TOKEN
- **fdde-511**: Address review findings — correct BemaCS descriptions from BEMA-Z catalog
- **fdde-511**: Address codex adversarial findings — correct BEMA descriptions from catalog
- **fdde-fi9**: Address review findings iteration 1 — R4 equivalence terminology in comments
- **fdde-r8r**: Correct equivalence comment from relatedto to equivalent in DVT/GOZ test

### Features

- **fdde-511**: Add meaningful descriptions to BemaCS and GozCS CodeSystems
- **fdde-fi9**: Green — document ConceptMap $translate test setup and add DICOM test file

### Miscellaneous

- **fdde-511**: Update changelog for BemaCS/GozCS description refactor
- Update changelog for fdde-r8r fix
- Bump version to 0.27.1

### Merge

- Worktree-bead-fdde-r8r

### Test

- **fdde-fi9**: Red — add httpyac $translate tests for DicomModalityToBemaSuggestion
- **fdde-fi9**: Add httpyac integration tests for ConceptMap $translate against live Aidbox

## [0.27.0] - 2026-05-02

### Bug Fixes

- **fdde-6rt**: Address review findings iteration 1
- **fdde-6rt**: Address codex adversarial findings
- **fdde-6rt**: Remove vendor string references from ConceptMap

### Documentation

- **fdde-4kk**: Add changelog entry for DicomModalityToBemaSuggestion ConceptMap
- **fdde-6rt**: Add changelog entry for SidexisLogicalNameToBemaGoz ConceptMap

### Features

- **fdde-4kk**: Add DicomModalityToBemaSuggestion ConceptMap and DX example
- **fdde-6rt**: Green — SidexisLogicalNameToBemaGoz ConceptMap + RadiationRelevantBillingCodeVS + SidexisLogicalNameCS
- **fdde-6rt**: Add SidexisLogicalNameToBemaGoz ConceptMap

### Miscellaneous

- **fdde-4kk**: Session close — DicomModalityToBemaSuggestion ConceptMap
- Bump version to 0.27.0

### Merge

- Worktree-bead-fdde-4kk
- Worktree-bead-fdde-6rt

### Test

- **fdde-6rt**: Red — stub FSH and test files for Sidexis ConceptMap

## [0.26.0] - 2026-05-01

### Bug Fixes

- **fdde-qzb**: Address review findings iteration 1

### Documentation

- Add Unreleased section for fdde-qzb imaging profile additions
- **fdde-qzb**: Update CHANGELOG with Unreleased section for imaging profile + ConceptMaps

### Features

- **fdde-qzb**: Add DentalImagingDiagnosticReportDE, BemaToGozSuggestion, ProcedureToBemaSuggestion, KfoRoentgenLink

### Miscellaneous

- **fdde-qzb**: Update praxis dep 0.41.1 → 0.43.1, remove duplicate ReportSubstatus from dental IG
- **fdde-qzb**: Update changelog via git-cliff
- Bump version to 0.26.0

## [0.25.1] - 2026-05-01

### Bug Fixes

- **fdde-2fg**: CI registry config and dep-version validation step
- **fdde-2fg**: Correct dist/package/package.json path in validation step
- **fdde-2fg**: Merge CI publish pipeline fixes into main

### Miscellaneous

- Bump de.cognovis.fhir.praxis pin to 0.43.0
- Bump version to 0.25.1

## [0.25.0] - 2026-04-30

### Miscellaneous

- Public root release 0.25.0


