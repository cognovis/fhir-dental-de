CodeSystem: ZtlMaterialCS
Id: ztl-material
Title: "ZTL Material"
Description: "Zahntechnische Materialien und Legierungsklassen für Laborleistungen. Basiert auf DIN EN ISO 22674 (Legierungsklassen) und klinischer Praxis."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/ztl-material"
* ^status = #active
* ^experimental = true
* ^caseSensitive = true
* ^content = #fragment
* ^publisher = "cognovis GmbH (Vorschlag)"

// Metalllegierungen
* #nem "NEM" "Nichtedelmetall-Legierung (basismetallhaltig, z.B. Kobalt-Chrom)"
* #em "EM" "Edelmetall-Legierung (hochgoldhaltiger Zahnersatz, >75% Edelmetallanteil)"
* #hochgold "Hochgold" "Hochgoldhaltige Legierung (>75% Gold + Platinmetalle)"
* #titan "Titan" "Titan oder Titanlegierung (implantologisch und als Gerüstmaterial)"

// Keramiken
* #vollkeramik "Vollkeramik" "Vollkeramische Versorgung (z.B. Zirkonoxid, Lithiumdisilikat)"
* #zirkon "Zirkonoxid" "Zirkonoxid-Gerüst (Y-TZP), häufig mit Verblendkeramik"
* #ips-emax "Lithiumdisilikat" "Presskeramik auf Lithiumdisilikat-Basis (z.B. IPS e.max)"
* #feldspat "Feldspatkeramik" "Feldspatporzellan-Verblendung auf Metallgerüst"

// Kunststoffe und Komposite
* #komposit "Kunststoff/Komposit" "Zahnfarbene Kunststoffversorgung (z.B. Prothesenzahn, Kunststoffverblendung)"
* #pmma "PMMA" "Polymethylmethacrylat (Prothesenbasis, Langzeitprovisorium)"
* #peek "PEEK" "Polyetheretherketon (metallfreie Gerüstalternative)"

// Sonstige
* #amalgam "Amalgam" "Zahntechnische Verarbeitung von Amalgam (selten)"
* #gold "Gegossenes Gold" "Gegossene Goldlegierung (Inlays, Onlays, Goldkronen)"
