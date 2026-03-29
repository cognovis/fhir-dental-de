CodeSystem: HkpGenehmigungsstatusCS
Id: hkp-genehmigungsstatus
Title: "HKP Genehmigungsstatus"
Description: "Status der Genehmigung eines Heil- und Kostenplans (HKP) durch die Krankenkasse."
* ^url = "https://fhir.cognovis.de/dental/CodeSystem/hkp-genehmigungsstatus"
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* ^publisher = "cognovis GmbH"

* #eingereicht "Eingereicht" "HKP wurde bei der Krankenkasse eingereicht und wartet auf Bearbeitung."
* #in-pruefung "In Prüfung" "HKP wird von der Krankenkasse geprüft."
* #genehmigt "Genehmigt" "HKP wurde von der Krankenkasse unverändert genehmigt."
* #abgelehnt "Abgelehnt" "HKP wurde von der Krankenkasse abgelehnt."
* #geaendert-genehmigt "Geändert genehmigt" "HKP wurde von der Krankenkasse mit Änderungen genehmigt (z.B. abweichende Positionen oder Eigenanteile)."
