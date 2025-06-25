local Translations = {
    info = {
        bag_full = "Ta torba może pomieścić tylko %{maxOutfits} strojów",
        changing_outfit = "Zmiana stroju...",
    },
    success = {
        outfit_saved = "Strój zapisany w torbie: %{outfitName}",
        outfit_loaded = "Strój załadowany: %{outfitName}",
        outfit_deleted = "Strój usunięty: %{outfitName}",
        outfit_edited = "Strój zaktualizowany: %{outfitName}",
    },
    error = {
        no_outfit_bag = "Nie masz torby na stroje",
        outfit_not_found = "Nie znaleziono stroju",
        cannot_use_here = "Nie możesz tutaj użyć torby na stroje",
        failed_to_save = "Nie udało się zapisać stroju",
        failed_to_load = "Nie udało się załadować stroju",
        failed_to_delete = "Nie udało się usunąć stroju",
        failed_to_edit = "Nie udało się zaktualizować stroju",
        invalid_name = "Nieprawidłowa nazwa stroju. Musi mieć od 1 do 50 znaków",
        blocked_zone = "Nie możesz zmieniać stroju w tym obszarze",
        no_permission = "Nie masz uprawnień do użycia tego",
    },
    menu = {
        outfit_bag = "Torba na Stroje",
        save_current = "Zapisz Obecny Strój",
        manage_outfits = "Zarządzaj Strojami",
        outfit_name = "Nazwa Stroju",
        save = "Zapisz Strój",
        load = "Załaduj Strój",
        delete = "Usuń Strój",
        access = "Otwórz Torbę",
        pickup = "Podnieś Torbę",
        save_description = "Zapisz swój obecny strój w torbie",
        storage = "Miejsce",
        action = "Akcja",
        save_action = "Zapisz obecny strój",
        note = "Notatka",
        save_note = "Wprowadź unikalną nazwę dla swojego stroju",
        save_title = "Zapisz Strój",
        outfit_name_desc = "Nadaj swojemu strojowi pamiętną nazwę",
        outfit_name_placeholder = "Mój Wspaniały Strój",
        outfit_desc = "Opis (Opcjonalnie)",
        outfit_desc_desc = "Dodaj notatki do tego stroju",
        outfit_desc_placeholder = "Mój ulubiony codzienny strój",
        no_description = "Brak opisu",
        saved_on = "Zapisano",
        unknown_date = "Nieznana data",
        actions_available = "Dostępne Akcje",
        actions_hint = "Kliknij, aby załadować lub usunąć",
        load_description = "Załóż ten strój",
        delete_description = "Usuń ten strój z torby",
        edit = "Edytuj Strój",
        edit_title = "Edytuj Szczegóły Stroju",
        edit_description = "Zmień nazwę lub opis tego stroju",
        no_outfits = "Brak Zapisanych Strojów",
        no_outfits_desc = "Zapisz swój pierwszy strój używając opcji powyżej"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 