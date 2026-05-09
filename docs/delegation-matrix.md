# Delegationsmatrix Parodontalbefund (PA-Status)

**Status:** internes Arbeitsdokument — nicht Teil der publizierten IG.
**Zweck:** Referenz für die Modellierung von `performer.qualification` auf PA-Observations (siehe Bead **fdde-ktj**).

> **Disclaimer:** Diese Matrix fasst den Stand von Gesetz, Richtlinien und Empfehlungen zusammen, ist aber **keine Rechtsberatung**. Verbindliche Auslegung im Einzelfall liegt bei der zuständigen KZV. Auslegungen variieren regional (z. B. KZV Nordrhein vs. Bayern).

## Rechtsgrundlagen

- **ZHG § 1 Abs. 5** — Delegationsrahmen heilkundlicher Tätigkeiten
- **G-BA PAR-Richtlinie** (gültig seit 01.07.2021) — Mindestbefunde für PAR-Antrag
- **DGZMK / DG-PARO S3-Leitlinie** AWMF-Reg.-Nr. 083-043 — wissenschaftlicher Behandlungsstandard
- **BZÄK / KZBV Delegationsempfehlungen** — Auslegung delegierbarer Tätigkeiten
- **§ 630a BGB** — zivilrechtliche Sorgfaltspflicht (Behandlungsvertrag)

## Grundprinzip

- **Diagnostik & Therapieentscheidung = Zahnarzt-Vorbehalt** (Heilkunde nach ZHG)
- **Mess- und Dokumentationstätigkeiten** sind delegierbar an qualifiziertes Personal — unter **Anordnung, Aufsicht und Verantwortung** des Zahnarztes
- Der Zahnarzt muss den **PAR-Status verifizieren und freigeben** — Delegation entbindet ihn nicht von der Verantwortung
- **BEMA-Position** wird immer auf den ZA abgerechnet, auch bei Delegation

## Befunderhebung nach Qualifikation

| Befund | ZA | DH | ZMF / ZMP | ZFA | Azubi |
|---|:---:|:---:|:---:|:---:|:---:|
| Anamnese-Vorerhebung | ✅ | ✅ | ✅ | ✅ | ❌ |
| Anamnese-Bewertung / Diagnose | ✅ | ❌ | ❌ | ❌ | ❌ |
| **PSI-Code erheben** | ✅ | ✅ | ✅ | ❌¹ | ❌ |
| **Sondierungstiefen messen** | ✅ | ✅ | ✅ | ⚠️² | ❌ |
| **BOP dokumentieren** | ✅ | ✅ | ✅ | ⚠️² | ❌ |
| **Rezession messen** | ✅ | ✅ | ✅ | ⚠️² | ❌ |
| **Furkationsbefall** | ✅ | ✅ | ✅ | ❌ | ❌ |
| **Lockerungsgrad** | ✅ | ✅ | ✅ | ❌ | ❌ |
| **CAL berechnen / interpretieren** | ✅ | ✅ | ✅ | ❌ | ❌ |
| Plaque-/Blutungsindex | ✅ | ✅ | ✅ | ✅ | ⚠️ |
| Röntgenbild anfertigen | ✅³ | ✅³ | ✅³ | ✅³ | ❌ |
| **Röntgen befunden** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Diagnose Stadium / Grad** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Therapieplan erstellen** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **PAR-Antrag unterschreiben** | ✅ | ❌ | ❌ | ❌ | ❌ |
| Subgingivale Instrumentierung (AIT) | ✅ | ✅ | ⚠️⁴ | ❌ | ❌ |
| UPT eigenständig durchführen | ✅ | ✅ | ⚠️ | ❌ | ❌ |
| MHU (BEMA 107 / 107a) | ✅ | ✅ | ✅ | ✅ | ❌ |

**Fußnoten:**

1. **ZFA und PSI**: nur assistierend unter direkter Aufsicht des ZA — nicht eigenständig
2. **ZFA und Sondieren / BOP / Rezession**: nur unter direkter Aufsicht ZA, nicht eigenverantwortlich; KZV-Auslegung uneinheitlich
3. **Röntgen** erfordert Fachkundenachweis nach RöV / StrlSchV
4. **AIT durch ZMF / ZMP**: bei Taschen > 5 mm empfiehlt BZÄK Vorbehalt für ZA / DH

## Detail nach Qualifikation

### Zahnarzt (ZA)

Vollumfänglich — inkl. Diagnose, Stadium / Grad, Therapieplanung, Antragstellung.

**Nicht delegierbar:**
- Diagnosestellung (Stage / Grade)
- Therapieentscheidung
- Befundbewertung
- Aufklärung des Patienten
- Unterschrift PAR-Antrag

### Dentalhygienikerin (DH) — höchste Aufstiegsqualifikation

- Komplette PA-Statuserhebung delegierbar (ST, BOP, Rezession, Furkation, Mobilität)
- Subgingivale Instrumentierung (AIT) auch in tiefen Taschen
- UPT eigenständig
- **Nicht erlaubt:** Diagnose, Therapieplan, PAR-Antrag

### ZMF / ZMP

- PA-Status messen und dokumentieren erlaubt
- AIT eingeschränkt delegierbar — Auslegung KZV-abhängig; bei Taschen > 5 mm DH / ZA-Vorbehalt empfohlen (BZÄK)
- UPT mit Einschränkungen

### ZFA ohne Aufstiegsqualifikation

- Anamnese-Vorerhebung, Plaque- / Blutungsindizes, Patientenaufklärung zu MHU-Inhalten
- PA-Sondierung **nur unter direkter Aufsicht** des ZA — nicht eigenverantwortlich
- Keine Furkation, keine Lockerung, keine CAL-Bewertung

### Auszubildende

- Nur unter unmittelbarer Anleitung
- Keine eigenständige Befunderhebung am Patienten

## Implikationen für das FHIR-Modell

### performer auf PA-Observations

Jede `Observation` mit PA-Bezug (PeriodontalObservationDE, PSIObservationDE, geplante Mobility-/Plaque-Slices) sollte einen `performer` mit Rolle / Qualifikation referenzieren. Vorgeschlagene Mechanismen:

- `Practitioner.qualification` mit kuratiertem ValueSet (ZA, DH, ZMF, ZMP, ZFA)
- Alternativ: `PractitionerRole.code`
- Diagnose-Conditions mit `ParStadiumExt` MÜSSEN von einem Performer mit ZA-Qualifikation stammen (Constraint oder Doku)

### Audit-Spur

Für KZV-Prüfungen und juristische Absicherung ist nachvollziehbar zu dokumentieren:

- Wer hat welchen Befund erhoben (Behandlerkürzel → Qualifikation)
- Wer hat den Befund freigegeben (ZA-Verifikation)
- Schriftliche Delegationsanordnung des ZA für PA-Tätigkeiten

### Querverweise zu Beads

- **fdde-ktj** — `performer.qualification` auf PA-Observations für Delegations-Audit
- **fdde-021** — Mobility-Slice (delegierbar an DH / ZMF / ZMP)
- **fdde-pky** — PSIObservationDE (delegierbar an DH / ZMF / ZMP)

## Quellen

- ZHG § 1 Abs. 5 — Zahnheilkundegesetz
- G-BA PAR-Richtlinie, BAnz AT 01.07.2021
- DGZMK / DG-PARO S3-Leitlinie 083-043 "Behandlung von Parodontitis Stadium I bis III"
- BZÄK / KZBV "Delegierbare Leistungen in der Zahnarztpraxis"
- Tonetti / Greenwell / Kornman 2018, J Clin Periodontol — Chicago-Klassifikation 2018
