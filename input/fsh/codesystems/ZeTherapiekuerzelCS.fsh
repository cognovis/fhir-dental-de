CodeSystem: ZeTherapiekuerzelCS
Id: ze-therapiekuerzel
Title: "ZE-Therapiekürzel (cognovis erweiterte Dental-Therapie-Taxonomie)"
Description: """
Cognovis-redaktionelle, **erweiterte** Therapiekürzel-Liste für die Zahnersatz-Soll-Versorgung. Verwendet im fhir-dental-de IG.

**Dies ist NICHT die offizielle KZBV-DPF-Therapiekürzel-Liste.** Für KZBV-EBZ-konforme Workflows ist die authoritative Code-Liste:

  - **`http://fhir.de/CodeSystem/kzbv/dpf-therapiekuerzel`** (43 Codes, EBZ Anlage 2 2022-05-25)
  - distributed via `de.cognovis.terminology.dental.dpf-kuerzel@2022.0.0` auf `npm.cognovis.de`

Anwendungs-Schicht muss explizit wählen welcher Namespace gemeint ist. Siehe ADR-004 in fhir-terminology-de.
"""
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/ze-therapiekuerzel"
* ^status = #active
* ^experimental = false
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (Vorschlag — erweitert KZBV DPF, nicht identisch)"

// Kronen und Brücken
* #K "Krone"
* #TK "Teleskopkrone"
* #B "Brücke"
* #BK "Brückenkonstruktion"
* #EK "Einzel-Krone"

// Prothesen
* #T "Teilprothese herausnehmbar"
* #V "Vollprothese"
* #PE "Partial-Prothese Erweiterung"
* #Komb "Kombinierter Zahnersatz"

// Implantologie
* #E "Einzel-Implantat"
* #Impl "Implantat einsetzen"
* #Expl "Implantat explantieren"

// Endodontie / Aufbau
* #WK "Wurzelkanalbehandlung"
* #W "Stift/Aufbau"

// Augmentation
* #KA "Knöcherne Augmentation"
* #SA "Sinuslift-Augmentation"
* #GBR "Gesteuerte Knochenregeneration"

// Konservierende Versorgung
* #Inl "Inlay"
* #Onl "Onlay"
* #ven "Veneer"
* #Prov "Provisorium"

// KFO
* #KFO-R "KFO-Retainer"

// Spezielle Verbindungselemente
* #Atx "Attachment"
* #Bar "Steg"

// Erweiterte Therapiekürzel
* #ZEK "Zahnersatz Krone"
* #ZEB "Zahnersatz Brücke"
* #ZEP "Zahnersatz Prothese"
* #ZEI "Zahnersatz Implantat"
* #ZET "Zahnersatz Totalprothese"
* #ZETP "ZE Teilprothese"
* #ZEV "Zahnersatz Veneer"
* #ZEIn "Zahnersatz Inlay"
* #ZEOn "Zahnersatz Onlay"
* #ZEOv "Zahnersatz Overlay"
* #ZEAuf "ZE Aufbau/Stift"
* #ZEPr "ZE Provisorium"
* #ZELp "ZE Langzeitprovisorium"
* #ZEKfx "ZE KFO-Retainer festsitzend"
* #ZEKhr "ZE KFO-Retainer herausnehmbar"
* #RepK "Reparatur Krone"
* #RepB "Reparatur Brücke"
* #RepP "Reparatur Prothese"
* #RepI "Reparatur Implantatversorgung"
* #RepV "Reparatur Veneer"
* #UntK "Unterfütterung Prothese"
* #UntPf "Unterfütterung mit Pflegemittel"
* #AbfF "Abformung für Festsitzend"
* #AbfH "Abformung für Herausnehmbar"
* #RegO "Registrierung Okklusion"
* #GBRz "Gesteuerte Knochenregeneration (Zahn)"
