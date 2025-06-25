local Translations = {
    info = {
        bag_full = "Deze tas kan maar %{maxOutfits} outfits bevatten",
        changing_outfit = "Outfit aan het veranderen...",
    },
    success = {
        outfit_saved = "Outfit opgeslagen in tas: %{outfitName}",
        outfit_loaded = "Outfit geladen: %{outfitName}",
        outfit_deleted = "Outfit verwijderd: %{outfitName}",
        outfit_edited = "Outfit bijgewerkt: %{outfitName}",
    },
    error = {
        no_outfit_bag = "Je hebt geen outfit tas",
        outfit_not_found = "Outfit niet gevonden",
        cannot_use_here = "Je kunt de outfit tas hier niet gebruiken",
        failed_to_save = "Outfit opslaan mislukt",
        failed_to_load = "Outfit laden mislukt",
        failed_to_delete = "Outfit verwijderen mislukt",
        failed_to_edit = "Outfit bijwerken mislukt",
        invalid_name = "Ongeldige outfit naam. Moet tussen 1-50 tekens zijn",
        blocked_zone = "Je kunt hier geen outfits veranderen",
        no_permission = "Je hebt geen toestemming om dit te gebruiken",
    },
    menu = {
        outfit_bag = "Outfit Tas",
        save_current = "Huidige Outfit Opslaan",
        manage_outfits = "Outfits Beheren",
        outfit_name = "Outfit Naam",
        save = "Outfit Opslaan",
        load = "Outfit Laden",
        delete = "Outfit Verwijderen",
        access = "Tas Openen",
        pickup = "Tas Oppakken",
        save_description = "Sla je huidige outfit op in de tas",
        storage = "Opslag",
        action = "Actie",
        save_action = "Huidige outfit opslaan",
        note = "Notitie",
        save_note = "Voer een unieke naam in voor je outfit",
        save_title = "Outfit Opslaan",
        outfit_name_desc = "Geef je outfit een memorabele naam",
        outfit_name_placeholder = "Mijn Geweldige Outfit",
        outfit_desc = "Beschrijving (Optioneel)",
        outfit_desc_desc = "Voeg notities toe aan deze outfit",
        outfit_desc_placeholder = "Mijn favoriete casual kleding",
        no_description = "Geen beschrijving",
        saved_on = "Opgeslagen op",
        unknown_date = "Onbekende datum",
        actions_available = "Beschikbare Acties",
        actions_hint = "Klik om te laden of verwijderen",
        load_description = "Deze outfit aantrekken",
        delete_description = "Deze outfit uit de tas verwijderen",
        edit = "Outfit Bewerken",
        edit_title = "Outfit Details Bewerken",
        edit_description = "Naam of beschrijving van deze outfit wijzigen",
        no_outfits = "Geen Opgeslagen Outfits",
        no_outfits_desc = "Sla je eerste outfit op met de optie hierboven"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 