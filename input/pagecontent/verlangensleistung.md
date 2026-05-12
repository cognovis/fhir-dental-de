# Verlangensleistung nach § 1 Abs. 2 Satz 2 GOZ

## Abgrenzung Heilbehandlung vs. Verlangensleistung

Verlangensleistungen sind zahnärztliche Leistungen, die **ohne medizinische Indikation** auf
ausdrückliches Verlangen des Patienten erbracht werden. Die Abgrenzung ist sowohl gebührenrechtlich
(§ 1 Abs. 2 Satz 2 GOZ) als auch steuerrechtlich (§ 4 Nr. 14a UStG) maßgeblich.

| Kriterium | Heilbehandlung | Verlangensleistung |
|---|---|---|
| Medizinische Indikation | ja | nein |
| § 4 Nr. 14a UStG anwendbar | ja → USt-frei | nein → USt-pflichtig 19 % |
| § 2 GOZ Vereinbarungspflicht (Abs. 1+2) | ja | entfällt (§ 2 Abs. 3 GOZ) |
| Faktor frei verhandelbar | nein (Schwellenwert 2,3 / 1,8) | ja |
| Schriftliche Vereinbarung empfohlen | nur bei Faktor > Schwellenwert | immer (Aufklärung, Beweissicherung) |

## Modellierung im IG

`VerlangensleistungExt` ist eine Extension auf `ChargeItem`, eingebunden in `GozChargeItemDE`.

Struktur:

- `extension[verlangensleistung].valueBoolean` — `true` markiert die Leistung als Verlangensleistung
- `extension[verlangensleistungBeleg].valueReference` — optionaler Verweis auf eine `DocumentReference`,
  die das ausdrückliche Patientenverlangen dokumentiert (Aufklärungsprotokoll, Behandlungsvertrag)

Beispiel siehe `ExampleGozChargeItemVerlangens` (Bleaching, Faktor 2,3, mit Beleg).

## Steuerliche Konsequenz

Da Verlangensleistungen **keine** Heilbehandlungen im Sinne § 4 Nr. 14a UStG sind, unterliegen sie
dem USt-Regelsatz von 19 %. Die konkrete Tax-Pattern-Anwendung (TaxCategoryExt=S, kein
TaxExemptionReason) erfolgt im Bead `fdde-8vf` über die in `ChargeItemPraxisDe` geerbten praxis-de
Tax-Extensions.

Bei korrekter Modellierung ergibt sich für eine Verlangensleistung:

```
ChargeItem (GozChargeItemDE)
├── extension[verlangensleistung].verlangensleistung = true
├── extension[steigerungsfaktor].faktor = <frei vereinbart>
├── extension[ext-tax-category] = tax-category-de#S        ← fdde-8vf
│   (kein extension[ext-tax-exemption-reason])             ← fdde-8vf
└── priceOverride = <brutto inkl. 19 % USt>
```

## Indikations-Prüfung

Die Einordnung einer GOZ-Leistung als Heilbehandlung oder Verlangensleistung obliegt im Einzelfall
dem behandelnden Zahnarzt. Folgende Anhaltspunkte (nicht abschließend):

- **Bleaching** ist regelmäßig Verlangensleistung — Ausnahme: Bleaching eines devital verfärbten
  Einzelzahns mit therapeutischer Intention
- **Veneer** kann Heilbehandlung sein (Substanzverlust durch Karies/Trauma/Erosion) oder reine
  Verlangensleistung (rein ästhetische Korrektur intakter Zähne)
- **Ästhetischer Aufschlag** auf eine sonst indizierte Versorgung (z.B. Vollkeramik-Aufschlag bei
  metallisch indizierter Krone) wird praxisüblich als **separate** Verlangensleistungs-Position
  abgerechnet — das ursprüngliche ChargeItem bleibt Heilbehandlung, der Aufschlag wird zur
  Verlangensleistung
- **PZR** ist Verlangensleistung NUR wenn ausschließlich ästhetisch motiviert; bei
  parodontologischer Indikation ist sie Heilbehandlung

Typische Beispiele (informativ, nicht abschließend) sind in `TypischeVerlangensleistungenVS` katalogisiert.

## Beweissicherung

§ 2 Abs. 3 GOZ hebt die Vereinbarungspflicht aus § 2 Abs. 1+2 GOZ auf, aber:

- Eine **schriftliche Aufklärung** über die Verlangensleistungs-Eigenschaft und die
  Vergütungspflicht (auch ohne medizinische Indikation) bleibt aus Beweissicherungsgründen
  dringend empfohlen
- Bei steuerprüferischer Kontrolle (USt-Sonderprüfung) ist die Beleglage entscheidend für die
  Anerkennung des § 4 Nr. 14a UStG-Ausschlusses
- Der `verlangensleistungBeleg`-Reference auf eine `DocumentReference` ermöglicht eine
  strukturierte Verknüpfung mit dem Aufklärungsprotokoll

## Querverweise

- Bead `fdde-0pf` — diese Markierungs-Extension
- Bead `fdde-8vf` — USt-Modellierung in dental ChargeItems (Tax-Pattern-Anwendung)
- Bead `fdde-co8` — § 2 GOZ-Vereinbarung modellieren (Faktor > 3,5; entfällt bei Verlangensleistung)
- `TypischeVerlangensleistungenVS` — informativer Beispielkatalog
