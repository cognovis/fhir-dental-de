CodeSystem: DentalBefundStatusCS
Id: dental-befund-status
Title: "Zahnärztlicher Befundstatus (cognovis-intern; teilweise DIN-13910-konform)"
Description: """
Cognovis-redaktionelle Befund-/Therapiestatus-Codes für die HKP-B-Zeile. Kleinbuchstaben = Befund (in Anlehnung an DIN-13910 / SWS-2.0 L001-Notation), Großbuchstaben = geplante Therapie (cognovis-Eigenkreation).

**Drei Vorbehalte — NICHT authoritativ:**

1. **Keine vollständige DIN-13910-Liste.** Die Kleinbuchstaben-Codes folgen *im Geist* DIN-13910 / SWS L001 (`f`=fehlend, `c`=kariös, `z`=zerstört, `e`=ersetzt, `i`=Implantat, `t`=Teleskopkrone), aber die vollständige DIN-Liste (~40 Codes inkl. `g`/`j`/`A`/`U`/`B`/`F`/`V`) ist hier nicht abgebildet. Authoritative DIN-Extraktion in **`fhir-term-uzw`** in fhir-terminology-de geplant.

2. **Therapie-Großbuchstaben kollidieren mit KZBV-DPF und DIN.** Z.B. dieses CS hat `K`="Krone geplant" (Therapie); KZBV-DPF `K`="Krone" (passiv, vorhandene Versorgung); DIN-13910 `K`="defective crown" (Befund). **Drei `K`s, drei Bedeutungen** — die `system`-URL einer `Coding` ist der einzig verlässliche Diskriminator.

3. **Nicht identisch mit `ze-befundkuerzel`/`ze-therapiekuerzel`.** Dieses CS lebt parallel und überlappt teilweise mit den cognovis-Vorschlag-CSes. Siehe **ADR-004** in `fhir-terminology-de/docs/adr/` für die volle 5-Taxonomien-Übersicht.

Für KZBV-EBZ-konforme HKP-Anträge verwende:
- `http://fhir.de/CodeSystem/kzbv/dpf-befundkuerzel` (33 Befund-Codes)
- `http://fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel` (43 Therapie-Codes)

Paket: `de.cognovis.terminology.dental.dpf-kuerzel@2022.0.0` auf `npm.cognovis.de`.

Status `#draft` markiert dieses CS als "wird beim DIN-Cleanup (fhir-term-uzw) noch angefasst".
"""
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/dental-befund-status"
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "cognovis GmbH (cognovis-internal — NOT authoritative DIN-13910)"

// Befund (Kleinbuchstaben)
* #f "fehlend" "Zahn fehlt"
* #z "zerstört" "Zahn ist zerstört und nicht erhaltungswürdig"
* #c "kariös" "Zahn hat Karies"
* #x "extraktionswürdig" "Zahn ist extraktionswürdig"
* #e "ersetzt" "Zahn ist durch Zahnersatz ersetzt"
* #k "Krone vorhanden" "Zahn ist mit einer Krone versorgt"
* #b "Brückenglied vorhanden" "Zahn ist als Brückenglied versorgt"
* #i "Implantat vorhanden" "Implantat ist vorhanden"
* #t "Teleskopkrone" "Zahn ist mit einer Teleskopkrone versorgt"
* #pw "erhaltungswürdiger Zahn mit partieller Zerstörung" "Teilweise zerstört, aber erhaltungswürdig"
* #ww "weitgehend zerstört, Erhaltungswürdigkeit fraglich" "Weitgehend zerstört"
* #ur "überkronungsbedürftig, Restzahnsubstanz reicht für Aufbau" "Überkronungsbedürftig"
* #uw "überkronungsbedürftig, Aufbau nötig" "Überkronungsbedürftig mit Aufbaufüllung"

// Therapie (Großbuchstaben)
* #E "Extraktion geplant" "Zahn soll extrahiert werden"
* #K "Krone geplant" "Kronenversorgung geplant"
* #B "Brückenglied geplant" "Brückenversorgung geplant"
* #PK "Teilkrone geplant" "Teilkrone geplant"
* #V "Veneer geplant" "Veneer geplant"
* #I "Implantat geplant" "Implantation geplant"
* #T "Teleskopkrone geplant" "Teleskopkrone geplant"
* #R "Regelversorgung" "Regelversorgung nach Festzuschuss-Richtlinie"
