// Example: GOZ Zahntechnik Eigenlabor — Vollkeramik-Krone Zahn 36
// Steuerlich: § 12 Abs. 2 Nr. 6 UStG / Anlage 2 Nr. 52 — ermäßigter Steuersatz 7%
// für selbst hergestellte zahntechnische Werkstücke aus Eigenlabor.

Alias: $gozCS = http://fhir.de/CodeSystem/bzaek/goz

Instance: ExampleGozZahntechWerkstueckChargeItem
InstanceOf: GozZahntechWerkstueckChargeItemDE
Usage: #example
Title: "Beispiel GOZ Eigenlabor-Werkstück Vollkeramik-Krone Zahn 36"
Description: "Vollkeramik-Krone aus dem Eigenlabor der Praxis für Zahn 36. Privatpatientin Charlotte von Hohenstein. Steuerlich: 7% USt (Eigenlabor § 12 Abs. 2 Nr. 6 UStG / Anlage 2 Nr. 52). Materialanteil mit ermäßigtem Steuersatz."

// TaxCategory = AA (7%) ist im Sub-Profil GozZahntechWerkstueckChargeItemDE fixiert
* extension[taxCategory].valueCodeableConcept = $UnCefact5305#AA "Ermaessigter Steuersatz"

* status = #billable

// GOZ 2200 — Vollkeramik-Krone (Werkstück-Anteil)
* code.coding[0] = $gozCS#2200 "Krone aus Vollkeramik"
* code.text = "Zahntechnisches Werkstück Eigenlabor — Vollkeramik-Krone"

* subject = Reference(Patient/pat-pkv-01)
* context = Reference(Encounter/enc-dental-02-privatschein)
* occurrenceDateTime = "2026-03-08"

// Werkstück-Preis (Eigenlabor-Materialkosten + Herstellungsanteil, brutto inkl. 7% USt)
* priceOverride.value = 285.60
* priceOverride.currency = #EUR

* bodysite = $fdiCS#36 "36"
* bodysite.text = "Zahn 36 — erster unterer linker Molar"
