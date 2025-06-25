local Translations = {
    info = {
        bag_full = "Questa borsa può contenere solo %{maxOutfits} outfit",
        changing_outfit = "Cambio dell'outfit in corso...",
    },
    success = {
        outfit_saved = "Outfit salvato nella borsa: %{outfitName}",
        outfit_loaded = "Outfit caricato: %{outfitName}",
        outfit_deleted = "Outfit eliminato: %{outfitName}",
        outfit_edited = "Outfit aggiornato: %{outfitName}",
    },
    error = {
        no_outfit_bag = "Non hai una borsa per outfit",
        outfit_not_found = "Outfit non trovato",
        cannot_use_here = "Non puoi usare la borsa per outfit qui",
        failed_to_save = "Impossibile salvare l'outfit",
        failed_to_load = "Impossibile caricare l'outfit",
        failed_to_delete = "Impossibile eliminare l'outfit",
        failed_to_edit = "Impossibile aggiornare l'outfit",
        invalid_name = "Nome outfit non valido. Deve essere tra 1-50 caratteri",
        blocked_zone = "Non puoi cambiare outfit in questa zona",
        no_permission = "Non hai il permesso di usare questo",
    },
    menu = {
        outfit_bag = "Borsa per Outfit",
        save_current = "Salva Outfit Attuale",
        manage_outfits = "Gestisci Outfit",
        outfit_name = "Nome Outfit",
        save = "Salva Outfit",
        load = "Carica Outfit",
        delete = "Elimina Outfit",
        access = "Accedi alla Borsa",
        pickup = "Raccogli Borsa",
        save_description = "Salva il tuo outfit attuale nella borsa",
        storage = "Spazio",
        action = "Azione",
        save_action = "Salva outfit attuale",
        note = "Nota",
        save_note = "Inserisci un nome unico per il tuo outfit",
        save_title = "Salva Outfit",
        outfit_name_desc = "Dai un nome memorabile al tuo outfit",
        outfit_name_placeholder = "Il Mio Outfit Fantastico",
        outfit_desc = "Descrizione (Opzionale)",
        outfit_desc_desc = "Aggiungi note su questo outfit",
        outfit_desc_placeholder = "Il mio abbigliamento casual preferito",
        no_description = "Nessuna descrizione",
        saved_on = "Salvato il",
        unknown_date = "Data sconosciuta",
        actions_available = "Azioni Disponibili",
        actions_hint = "Clicca per caricare o eliminare",
        load_description = "Indossa questo outfit",
        delete_description = "Rimuovi questo outfit dalla borsa",
        edit = "Modifica Outfit",
        edit_title = "Modifica Dettagli Outfit",
        edit_description = "Modifica il nome o la descrizione di questo outfit",
        no_outfits = "Nessun Outfit Salvato",
        no_outfits_desc = "Salva il tuo primo outfit usando l'opzione sopra"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 