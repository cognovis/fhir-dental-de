# USt-Modellierung in dental ChargeItems

Dieser Abschnitt beschreibt, wie BEMA- und GOZ-Leistungen umsatzsteuerlich modelliert werden.
Die strukturelle Basis liefert praxis@0.64.0 via `ChargeItemPraxisDe` mit den geerbten Extensions
`TaxCategoryExt` und `TaxExemptionReasonExt`. Dental-spezifisch sind die Pattern-Defaults,
Invarianten und das Sub-Profil für Eigenlabor-Werkstücke.

## Steuerrechtliche Grundlagen

| Sachverhalt | Rechtsgrundlage | Konsequenz |
|---|---|---|
| Heilbehandlung (GKV BEMA, GOZ medizinisch indiziert) | § 4 Nr. 14a UStG | steuerfrei (TaxCategory `E`) |
| Verlangensleistung (§ 1 Abs. 2 Satz 2 GOZ) | KEINE Heilbehandlung | 19 % Regelsatz (`S`) |
| Zahntechnisches Werkstück Eigenlabor | § 12 Abs. 2 Nr. 6 UStG, Anlage 2 Nr. 52 | 7 % ermäßigt (`AA`) |
| Zahntechnisches Werkstück Fremdlabor durchgereicht | Regelsatz | 19 % (`S`) |
| Kleinunternehmerregelung praxisweit | § 19 UStG | Override aller Positionen auf 0 % mit Hinweispflicht (Organization-Level via `KleinunternehmerregelungExt`) |

Trennungsprinzip: jede Leistungsposition trägt ihren eigenen Steuersatz. Praxis-weite
Sonderregeln (Kleinunternehmer, Abfärbung) wirken als Override auf der Organization-Ebene
(siehe `DentalOrganizationDE` und die geerbte `KleinunternehmerregelungExt` aus praxis-de).

## Modellierung via praxis-de Extensions

```
ChargeItem (BemaChargeItemDE oder GozChargeItemDE)
├── extension[ext-tax-category].valueCodeableConcept
│     System: urn:un:unece:uncefact:codelist:standard:5305 (EN 16931 / UN-CEFACT 5305)
│     Codes:  S=19% | AA=7% | E=steuerfrei | AE=Reverse-Charge | Z=Nullsatz
└── extension[ext-tax-exemption-reason].valueCodeableConcept  (nur wenn TaxCategory=E)
      System: https://fhir.cognovis.de/praxis/CodeSystem/ust-befreiungsgrund
      Codes:  para4-nr14a | para4-nr14b | para4-nr16 | para4-nr17a | para4-nr23 | kleinunternehmer-para19
```

## Profil-spezifische Pattern

### BemaChargeItemDE — fix steuerfrei

BEMA-Leistungen sind ausnahmslos GKV-Heilbehandlung. Beide Tax-Extensions sind im Profil
fix gesetzt und müssen nicht in jeder Instanz angegeben werden (sind aber explizit in den
Examples mitsynchronisiert, damit der Build IGs prüft):

- `extension[taxCategory].valueCodeableConcept = urn:un:unece:uncefact:codelist:standard:5305#E`
- `extension[taxExemptionReason].valueCodeableConcept = ust-befreiungsgrund#para4-nr14a`

### GozChargeItemDE — kontextabhängig (E / S / AA)

GOZ-Leistungen können je nach Indikation und Werkstück-Anteil unterschiedlich besteuert sein.
Beide Extensions sind MS, mit zwei verbindlichen Invarianten:

**Invariant `goz-tax-iff-e`** (bi-direktional):
```
extension[ext-tax-category].coding.code = 'E' = extension[ext-tax-exemption-reason].exists()
```
- Wenn TaxCategory=E → TaxExemptionReason MUSS gesetzt sein
- Wenn TaxCategory ∈ {S, AA, AE, Z} → TaxExemptionReason DARF NICHT gesetzt sein

**Invariant `goz-tax-verlangens-s`** (Trigger):
```
extension[verlangensleistung].verlangensleistung = true implies extension[ext-tax-category].coding.code = 'S'
```
- Eine Verlangensleistung MUSS mit TaxCategory=S markiert sein

Damit decken die Invarianten die drei GOZ-Fälle ab:

| Fall | TaxCategory | TaxExemptionReason | Erfüllt durch |
|---|---|---|---|
| Medizinisch indizierte Heilbehandlung (Default) | `E` | `para4-nr14a` | beide Extensions setzen |
| Verlangensleistung | `S` | (nicht gesetzt) | VerlangensleistungExt=true → Invariant goz-tax-verlangens-s |
| Eigenlabor-Werkstück | `AA` | (nicht gesetzt) | Sub-Profil GozZahntechWerkstueckChargeItemDE |
| Kleinunternehmer praxisweit | `E` | `kleinunternehmer-para19` | manuell setzen, wenn DentalOrganizationDE.KleinunternehmerregelungExt aktiv |

### GozZahntechWerkstueckChargeItemDE — Sub-Profil für Eigenlabor

Sub-Profil von `GozChargeItemDE` mit fixiertem `TaxCategory=AA` und verbotenem
`TaxExemptionReason` (`0..0`). Verwendung für selbst hergestellte Werkstücke aus dem
Eigenlabor der Praxis (Krone, Brücke, Inlay, Onlay, Aufbissschiene etc.).

Fremdlabor-durchgereichte Werkstücke (Regelsatz 19 %) werden NICHT durch dieses
Sub-Profil abgedeckt — dort `GozChargeItemDE` direkt mit `TaxCategory=S` verwenden.

## ZE Mischrechnung — Vorausschau

Ein Heil- und Kostenplan (ZE) kombiniert regelmäßig:

- BEMA-Anteil (Festzuschuss, steuerfrei `E` + `para4-nr14a`)
- GOZ-Heilbehandlungsanteil (steuerfrei `E` + `para4-nr14a`)
- Eigenlabor-Werkstück (`AA`)
- ggf. Verlangens-Aufschlag (`S`)

Jede Position trägt ihren eigenen Steuersatz; die Aggregation auf Rechnungsebene
(Invoice mit lineItem.priceComponent type=tax) erfolgt im GozInvoiceDE-Profil
(§ 10 GOZ) bzw. in der End-to-End-Mischrechnung.

## Querverweise

- [Verlangensleistung](verlangensleistung.html) — § 1 Abs. 2 Satz 2 GOZ
- praxis-de `TaxCategoryExt`, `TaxExemptionReasonExt`, `KleinunternehmerregelungExt`
