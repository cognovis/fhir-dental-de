CodeSystem: ZeBefundkuerzelCS
Id: ze-befundkuerzel
Title: "Dental Befund-Status (cognovis-intern, ergänzend zu KZBV)"
Description: """
**Klinische Befund-Status-Codes für die zahnärztliche Dokumentation**, die *über* die offiziellen KZBV-Code-Listen hinausgehen. Verwendet in `CarePlan.extension[ze-befundkuerzel]` wo der Workflow eine Status-Notation braucht die EBZ Anlage 2 / FZ-Kompendium nicht abbildet (z.B. "Krone defekt", "Magnetanker", "Inlay (Keramik)").

## Diese CS ist NICHT die KZBV-DPF-Liste

Für KZBV-EBZ-konforme Workflows (eHKP, Anträge, Genehmigungsverfahren) verwende die **authoritativen KZBV-Code-Listen**:

| Use-Case | Authoritative CS | Paket |
|---|---|---|
| HKP-Befund-Notation im Zahnschema (eHKP, ab 2022-01-01 verbindlich) | `http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel` (33 Codes, EBZ Anlage 2 2022-05-25) | `de.cognovis.terminology.dental.dpf-kuerzel@2022.0.0` |
| Festzuschuss-Befunde (§ 55 SGB V Anspruchskategorisierung) | `https://fhir.cognovis.de/dental/CodeSystem/festzuschuss-befund` (54 Codes, 1.1–8.6) | im IG; Volltext-Supplement in `de.cognovis.terminology.dental.festzuschuss` |

Beide KZBV-Taxonomien sind **disjunkt** (numerische FZ-Codes vs. alphabetische DPF-Kürzel) — verwechsle sie nicht.

## Bindung extensible

Die Extension `ze-befundkuerzel` bindet diese CS **`extensible`**: für nicht abgedeckte Konzepte können Konsumenten direkt KZBV-DPF-Codes (`http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel#…`) verwenden.

## Code-Konflikt-Warnung

Manche Codes in dieser cognovis-CS überlappen *lexikalisch* mit KZBV-DPF, haben aber **andere Semantik**. Beim Persistieren von Daten ist die `system`-URL entscheidend:

| Code | Diese CS (cognovis) | KZBV-DPF (`fhir.de/CodeSystem/kzbv/dpf-befundkuerzel`) |
|------|----------------------|---------------------------------------------------------|
| `x`  | Zahn fehlt           | nicht erhaltungswürdiger Zahn                          |

Siehe `docs/adr/ADR-004-dental-befund-namespaces.md` in fhir-terminology-de für die volle Geschichte und Migrationsstrategie.
"""
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (cognovis-internal supplement to KZBV codes)"

// =============================================================================
// Backward-compatible code (preserves seed/test fixtures in install-pvs and
// fhir-dental-de examples). For new development bind against
// http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel instead.
// =============================================================================
* #x "Zahn fehlt"  "Kompatibilitäts-Eintrag — entspricht KZBV-DPF `f` (fehlender Zahn). Bei Neuentwicklung bevorzuge `fhir.de/CodeSystem/kzbv/dpf-befundkuerzel#f`."

// =============================================================================
// Klinische Befund-Status-Codes — Konzepte die EBZ Anlage 2 NICHT abbildet
// (KZBV DPF konzentriert sich auf HKP-relevante Versorgungs-Status; hier:
// allgemeiner Praxis-Befundstatus für Karteikarte/Anamnese)
// =============================================================================

// Implantat-Versorgungen
* #impl  "Implantat"
* #ikr   "Implantatgetragene Krone"
* #ibrg  "Implantatgetragenes Brückenglied"

// Defekt-/Reparatur-Status (laufende Praxis-Dokumentation, nicht HKP)
* #kd    "Krone defekt"
* #kr    "Kronreparatur nötig"
* #pd    "Prothese defekt"
* #prd   "Prothese reparaturbedürftig"

// Konservierende Versorgung (Inlay-Materialien — vs. KZBV-DPF abstraktes `i`)
* #ie    "Inlay-Ersatz"
* #ic    "Inlay (Keramik)"
* #ig    "Inlay (Gold/Guß)"
* #ik    "Inlay (Kunststoff)"
* #vn    "Veneer"

// Verbindungselemente / Halte-Attachments (KZBV-DPF hat hier nur generisches `so`)
* #Atx   "Attachment"
* #Bar   "Stegverankerung"
* #LocA  "Locator-Attachment"
* #BallA "Kugelkopf-Attachment"
* #MagA  "Magnetanker"

// Parodontologie-Status (KZBV-DPF hat dazu kein eigenes Befundkürzel)
* #pa    "Parodontal behandlungsbedürftig"
