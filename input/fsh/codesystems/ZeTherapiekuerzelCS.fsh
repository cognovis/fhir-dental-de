CodeSystem: ZeTherapiekuerzelCS
Id: ze-therapiekuerzel
Title: "Dental Therapie-Status (cognovis-intern, ergänzend zu KZBV)"
Description: """
**Klinische Therapie-Status-Codes für die zahnärztliche Dokumentation**, die *über* die offiziellen KZBV-Code-Listen hinausgehen. Verwendet in `CarePlan.extension[ze-therapiekuerzel]` wo der Workflow eine Status-Notation braucht die EBZ Anlage 2 nicht abbildet (KFO-Retainer, Augmentation, Reparaturen, Unterfütterungen).

## Diese CS ist NICHT die KZBV-DPF-Liste

Für KZBV-EBZ-konforme Workflows (eHKP-Therapieplanung) verwende die **authoritative KZBV-Liste**:

- **`http://fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel`** (43 Codes, EBZ Anlage 2 2022-05-25 — `K`, `B`, `T`, `SB`, `SK`, `T2`, …)
- Paket `de.cognovis.terminology.dental.dpf-kuerzel@2022.0.0` auf `npm.cognovis.de`.

## Bindung extensible

Die Extension `ze-therapiekuerzel` bindet diese CS **`extensible`**: KZBV-DPF-Codes sind ebenfalls valide.

## Code-Konflikt-Warnung

Manche Codes überlappen *lexikalisch* mit KZBV-DPF mit unterschiedlicher Semantik:

| Code | Diese CS (cognovis) | KZBV-DPF |
|------|----------------------|-----------|
| `B`  | Brücke               | Brückenglied |
| `K`  | Krone (allgemein)    | Krone (intakt — siehe KZBV-DPF) |

Siehe `docs/adr/ADR-004-dental-befund-namespaces.md` in fhir-terminology-de für Migrations-Strategie.
"""
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/ze-therapiekuerzel"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (cognovis-internal supplement to KZBV codes)"

// =============================================================================
// Backward-compatible code (preserves seed/test fixtures in install-pvs and
// fhir-dental-de examples). For new development bind against
// http://fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel instead.
// =============================================================================
* #B "Brücke" "Kompatibilitäts-Eintrag. KZBV-DPF `B` ist semantisch enger (Brückenglied). Bei Neuentwicklung bevorzuge `fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel`."

// =============================================================================
// Klinische Therapie-Status-Codes — Konzepte die EBZ Anlage 2 nicht abbildet
// (KZBV-DPF deckt prothetische Standard-Versorgung ab; hier: KFO, chirurg.
// Vorbehandlung, Reparaturen, Unterfütterungen)
// =============================================================================

// Konservierende Versorgung
* #Inl   "Inlay"
* #Onl   "Onlay"
* #ven   "Veneer"
* #Prov  "Provisorium"

// Kieferorthopädie (KZBV-DPF deckt nur prothetische ZE-Versorgung ab)
* #KFO-R "KFO-Retainer"

// Chirurgische Vorbehandlung / Augmentation (kein KZBV-DPF-Code)
* #Expl  "Implantat explantieren"
* #KA    "Knöcherne Augmentation"
* #SA    "Sinuslift-Augmentation"
* #GBR   "Gesteuerte Knochenregeneration"
* #GBRz  "Gesteuerte Knochenregeneration (Zahn)"

// Reparatur-Therapien (KZBV-DPF kennt nur Vollerneuerung)
* #RepK  "Reparatur Krone"
* #RepB  "Reparatur Brücke"
* #RepP  "Reparatur Prothese"
* #RepI  "Reparatur Implantatversorgung"
* #RepV  "Reparatur Veneer"

// Prothesen-Wartung
* #UntK  "Unterfütterung Prothese"
* #UntPf "Unterfütterung mit Pflegemittel"

// Diagnostik / Hilfsleistungen für Therapieplanung
* #AbfF  "Abformung für Festsitzend"
* #AbfH  "Abformung für Herausnehmbar"
* #RegO  "Registrierung Okklusion"
