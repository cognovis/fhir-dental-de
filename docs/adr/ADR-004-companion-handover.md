# Handover — Dental-Befund-Taxonomien

**Adressat**: Dirk (oder wer auch immer hier weitermacht)
**Stand**: 2026-05-12
**Master-Quelle**: `~/code/fhir-terminology-de/docs/adr/ADR-004-dental-befund-namespaces.md`

---

## TL;DR

Im deutschen Dental-Bereich existieren **mindestens 5 parallele Befund-/Status-Code-Taxonomien** mit überlappenden Letters und unterschiedlicher Semantik. Bis Mai 2026 wurden sie in fhir-dental-de wild durcheinandergeworfen. Diese Handover-Doku ist die Karte.

**Was bereits aufgeräumt ist** (in main, kein Action-Required):

- `ZeBefundkuerzelCS` + `ZeTherapiekuerzelCS` von 51/47 auf 17/17 Codes gestutzt, Title/Description honest, Binding `required → extensible`.
- `DentalBefundStatusCS` Title/Description geupdatet, `^status = #draft` als "DIN-Cleanup-Marker".
- `sws-mapping.md` Korrektur: keine `(z.B. 1.1, 2.3)` Beispiele mehr — die waren falsch (Festzuschuss-Codes statt DPF-Kürzel).
- `codesystems.md` hat jetzt eine "Die drei (jetzt vier) KZBV-Taxonomien"-Tabelle.

**Was noch offen ist** — siehe Action-Liste unten.

---

## Die 5 Taxonomien auf einen Blick

| # | Taxonomie | URL | Workflow | Im fhir-dental-de IG | Authoritative Paket |
|---|---|---|---|---|---|
| 1 | **KZBV Festzuschuss-Befunde** (1.1–8.6) | `https://fhir.cognovis.de/dental/CodeSystem/festzuschuss-befund` | § 55 SGB V FZ-Berechnung | `FestzuschussBefundCS` (content=fragment) | `de.cognovis.terminology.dental.festzuschuss` (Supplement mit Volltext) |
| 2 | **KZBV DPF-Befundkürzel** (`a`/`b`/`e`/`k`/`x`…) | `http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel` | eHKP-Zahnschema (EBZ Anlage 2, Pflicht ab 2022) | — *(extern referenziert)* | `de.cognovis.terminology.dental.dpf-kuerzel@2022.0.0` |
| 3 | **KZBV DPF-Therapiekürzel** (`K`/`B`/`SB`…) | `http://fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel` | eHKP-Therapieplanung | — *(extern referenziert)* | selbes Paket wie #2 |
| 4 | **DIN-13910 / SWS Zahnstatus** (~40 codes: f/c/C/z/e/x/w/g/k/j/K/p/t/A/U/b/B/F/i/V + 30 weitere) | (geplant: `http://fhir.de/CodeSystem/din-13910/zahnstatus`) | Karteikarten-Befund pro Zahn, SWS L001-Records | `DentalBefundStatusCS` (TEILABDECKUNG, 15 von ~40, mit eigener Therapie-Erweiterung) | **fehlt noch** — Bead `fhir-term-uzw` in fhir-terminology-de |
| 5 | **cognovis-ergänzend** (Status ausserhalb der KZBV-Workflows) | `https://fhir.cognovis.de/dental/CodeSystem/ze-befundkuerzel` + `…/ze-therapiekuerzel` | Karteikarten-Detail (Krone defekt, Magnetanker, KFO-Retainer, Reparatur, …) | `ZeBefundkuerzelCS` + `ZeTherapiekuerzelCS` (gestutzt 17+17) | im IG, content=fragment |

### Wo es richtig knackt

Lexikalisch überlappende Codes mit **unterschiedlicher Semantik**:

| Code | (#1) FZ | (#2) DPF-Befund | (#4) DIN/SWS | (#5) cognovis | `DentalBefundStatusCS` |
|------|----|----|----|----|----|
| `x` | — | nicht erhaltungswürdig | extrahieren | Zahn fehlt | extraktionswürdig |
| `e` | — | ersetzter Zahn | replaced | (entfernt) | ersetzt |
| `k` | — | klinisch intakte Krone | crown (Befund) | (entfernt) | Krone vorhanden |
| `K` | — | — | defective crown (Befund) | — | **Krone geplant** (Therapie) |
| `B` | — | — | bridge abutment (Befund) | Brücke | **Brückenglied geplant** (Therapie) |

**Daher Regel**: Bei `Coding` ist **immer die `system`-URL der einzige verlässliche Diskriminator**. Niemals nur am `code` arbeiten.

---

## Action-Liste — wenn die 5 fhir-terminology-de Follow-up-Beads landen

Jeder Follow-up-Bead in fhir-terminology-de bringt downstream fhir-dental-de-Anpassungen mit. Die Acceptance-Criteria der jeweiligen Beads listen die fhir-dental-de-Touchpoints explizit auf (Notes-Sektion "fhir-dental-de impact"). Hier die Übersicht:

### `fhir-term-uzw` — DIN-13910 / SWS Zahnstatus (P3, feature)

**Wichtigster Bead.** Wenn das authoritative DIN-CS extrahiert ist:

1. **`input/fsh/codesystems/DentalBefundStatusCS.fsh`** — Entscheidung treffen:
   - (a) Kleinbuchstaben-Teil rebound auf DIN-Namespace, Großbuchstaben (Therapie) bleibt cognovis,
   - (b) komplett als cognovis-Overlay bestehen lassen wie ze-befundkuerzel,
   - (c) splitten in zwei separate CSes (Befund-Status + Therapie-Plan).
   - Aktuell `^status = #draft` — Marker dass das hier noch entschieden werden muss.
2. **`input/fsh/profiles/DentalCarePlanDE.fsh`** — Profile bindet `ZeBefundkuerzelExt` (jetzt extensible). DIN-Codes werden automatisch first-class.
3. **`input/fsh/examples/ExampleHkpCarePlan.fsh` + `ExampleZeCarePlan.fsh`** — neues Beispiel mit DIN-Namespace hinzufügen.
4. **`input/pagecontent/sws-mapping.md`** — Section "Clinical Finding Codes" updaten mit authoritativer DIN-CS-URL.
5. **`input/pagecontent/codesystems.md`** — DIN-Zahnstatus zur 5-Taxonomien-Tabelle hinzufügen.

### `fhir-term-sf9` — KZBV Härtefall-Kategorien (P3, feature)

1. **`input/fsh/extensions/ZeHaerteFall*.fsh`** (oder wo Härtefall heute lebt) — auf neue authoritative CS umbinden.
2. Examples mit Härtefall-Coding ergänzen.
3. CHANGELOG-Entry.

### `fhir-term-57p` — KZBV PAR-Richtlinie ATG/UPT/BEV (P3, task)

1. **`input/fsh/extensions/ParStadiumExt.fsh`** — verifizieren dass das richtige ValueSet gebunden wird.
2. **PAR-Befund-Observations** — Code-Referenzen verifizieren.
3. Neue Extensions für UPT-Stufen + ATG-Status, falls heute fehlen.
4. Examples für PAR-Workflow mit authoritativen Codes.

### `fhir-term-4x5` — SWS administrative Enums D003/R001-03/V022/L001-16 (P4, task)

1. **DocumentReference-Profile** — D003 Template-Type binding.
2. **Invoice/Claim-Profile** — R001-03 invoice-type binding.
3. **Coverage-Profile** — V022 Card-Type binding (oder mit de.basisprofil.r4 koordinieren).
4. **Encounter-Profile** — L001-16 Billing-Area binding (eher fhir-praxis-de als dental).
5. **Audit zuerst**: prüfen welche Felder de.basisprofil.r4 schon abdeckt.

### `fhir-term-g8z` — EBZ Anlage 1 Satzart-Schlüsselzahlen (P4, spike)

Erst Spike. Falls Adapter/PLATFORM EBZ-EDI-Format überhaupt produzieren/konsumieren → CSes + Bundle/MessageHeader-Bindings. Wenn FHIR-REST das EBZ-EDI komplett ablöst → keine fhir-dental-de-Anpassung nötig.

### Cross-Repo: `adapter-3quq` und `platform-s5xoh`

Auch wenn diese in Adapter/platform gelistet sind, betreffen sie fhir-dental-de indirekt:

- **`adapter-3quq`** — Adapter-Rebinding aller heute gegen cognovis-Vorschlag-URL persistierter Daten. Bei produktiver Migration auf KZBV-DPF-Namespace muss fhir-dental-de keine Code-Änderung machen, aber neue Validierungs-Test-Cases helfen den Konsumenten.
- **`platform-s5xoh`** — Audit der `platform.cognovis.de/fhir/CodeSystem/ze-*`-URLs. Wenn die existieren und produktive Daten dagegen liegen, ist das ein weiterer Cleanup-Pfad. Falls die URLs nicht existieren → Adapter-Docs korrigieren.

---

## Aktuelle FSH-Touchpoints (Cheat-Sheet)

| Datei | Was steht drin | Was zu tun ist |
|---|---|---|
| `input/fsh/codesystems/FestzuschussBefundCS.fsh` | 54 FZ-Codes (1.1–8.6), `content=fragment` | Nichts — Volltext-Supplement ist in `de.cognovis.terminology.dental.festzuschuss` |
| `input/fsh/codesystems/ZeVersorgungsteilCS.fsh` | 15 Versorgungsteile (1–14.2), `content=fragment` | Nichts — Supplement im selben Paket |
| `input/fsh/codesystems/ZeBefundkuerzelCS.fsh` | 17 cognovis-Vorschlag-Codes | Im Cleanup gestutzt, `extensible` binding |
| `input/fsh/codesystems/ZeTherapiekuerzelCS.fsh` | 17 cognovis-Therapie-Codes | dito |
| `input/fsh/codesystems/DentalBefundStatusCS.fsh` | 15 DIN-13910-ähnliche Codes + 8 Therapie-Codes | **`^status=#draft`** — wartet auf `fhir-term-uzw` |
| `input/fsh/extensions/ZeBefundkuerzelExt.fsh` | Bindet ZeBefundkuerzelVS (`extensible`) | Akzeptiert jetzt auch `http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel` |
| `input/fsh/extensions/ZeTherapiekuerzelExt.fsh` | analog | dito |
| `input/fsh/profiles/DentalCarePlanDE.fsh` | Profile bindet die Extensions | Nichts — kommt automatisch durch die extensible binding mit |
| `input/pagecontent/codesystems.md` | Doku-Seite | Hat jetzt 3-Taxonomien-Tabelle; nach `uzw` auf 4 erweitern |
| `input/pagecontent/sws-mapping.md` | SWS 2.0 → FHIR Mapping | "(z.B. 1.1, 2.3)" Fehler korrigiert; nach `uzw` weitere Updates |

---

## Cross-Reference

- **Master-ADR**: `~/code/fhir-terminology-de/docs/adr/ADR-004-dental-befund-namespaces.md`
- **DPF-Kürzel-Paket**: `~/code/fhir-terminology-de/packages/de.cognovis.terminology.dental.dpf-kuerzel/`
- **SWS 2.0 Master-Spec**: `~/code/fhir-dental-de/docs/SWS2.0_Research_Summary.md`
- **Pvs-Befund-Decoding Spike**: `~/code/adapter/packages/pvs-pvs/docs/zahnstatus-decoding.md`

## Beads im Spiel (Stand 2026-05-12)

| Repo | ID | Status | Was |
|---|---|---|---|
| fhir-terminology-de | fhir-term-5mq | ✓ closed | DPF-Kürzel-Paket gebaut |
| fhir-terminology-de | fhir-term-70l | ✓ closed | Cross-Repo-Coordination |
| fhir-terminology-de | **fhir-term-uzw** | ○ open P3 | DIN-13910 — die wichtigste Lücke |
| fhir-terminology-de | fhir-term-sf9 | ○ open P3 | Härtefall |
| fhir-terminology-de | fhir-term-57p | ○ open P3 | PAR-Richtlinie |
| fhir-terminology-de | fhir-term-4x5 | ○ open P4 | SWS-Admin-Enums |
| fhir-terminology-de | fhir-term-g8z | ○ open P4 | EBZ Anlage 1 (Spike) |
| adapter | adapter-3quq | ○ open P2 | Adapter-Rebinding |
| platform | platform-s5xoh | ○ open P3 | Platform URL-Audit |
