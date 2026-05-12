// Sub-profile of GozChargeItemDE for in-house zahntechnische Werkstücke (Eigenlabor).
//
// Steuerliche Grundlage: § 12 Abs. 2 Nr. 6 UStG i.V.m. Anlage 2 Nr. 52 — ermäßigter
// Steuersatz 7% für selbst hergestellte zahntechnische Werkstücke aus dem Eigenlabor
// der Zahnarztpraxis. Fremdlabor-durchgereichte Werkstücke unterliegen dem Regelsatz
// 19% (sind nicht durch dieses Profil abgedeckt).
//
// Fixiert in diesem Sub-Profil:
//   TaxCategory = AA (7% ermäßigt) — überschreibt das Default-E von GozChargeItemDE
//   TaxExemptionReason: 0..0 (verboten — bei AA gibt es keine Befreiung, sondern Ermäßigung)
//
// Die GozChargeItemDE-Invariant goz-tax-iff-e bleibt erfüllt: TaxCategory!=E → kein Befreiungsgrund.

Profile: GozZahntechWerkstueckChargeItemDE
Parent: GozChargeItemDE
Id: goz-zahntech-werkstueck-charge-item
Title: "GOZ Zahntechnisches Werkstück Eigenlabor (DE)"
Description: "Sub-Profil von GozChargeItemDE für in-house zahntechnische Werkstücke (Eigenlabor) mit ermäßigtem USt-Satz 7% nach § 12 Abs. 2 Nr. 6 UStG / Anlage 2 Nr. 52. Fremdlabor-Werkstücke werden NICHT durch dieses Profil abgedeckt (Regelsatz 19% → GozChargeItemDE direkt mit TaxCategory=S verwenden)."
* ^status = #active
* ^experimental = false
* ^publisher = "cognovis GmbH"

// --- USt fix: 7% ermäßigt für Eigenlabor-Werkstücke ---
* extension[taxCategory].valueCodeableConcept = $UnCefact5305#AA "Ermaessigter Steuersatz"
* extension[taxCategory] ^short = "USt-Kategorie (fix = AA / 7% ermäßigt nach § 12 Abs. 2 Nr. 6 UStG, Anlage 2 Nr. 52)"

// TaxExemptionReason 0..0 — keine Befreiung bei Ermäßigung
* extension[taxExemptionReason] 0..0
