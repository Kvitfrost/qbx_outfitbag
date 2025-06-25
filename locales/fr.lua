local Translations = {
    info = {
        bag_full = "Ce sac ne peut contenir que %{maxOutfits} tenues",
        changing_outfit = "Changement de tenue...",
    },
    success = {
        outfit_saved = "Tenue enregistrée dans le sac: %{outfitName}",
        outfit_loaded = "Tenue chargée: %{outfitName}",
        outfit_deleted = "Tenue supprimée: %{outfitName}",
        outfit_edited = "Tenue mise à jour: %{outfitName}",
    },
    error = {
        no_outfit_bag = "Vous n'avez pas de sac à tenues",
        outfit_not_found = "Tenue non trouvée",
        cannot_use_here = "Vous ne pouvez pas utiliser le sac à tenues ici",
        failed_to_save = "Échec de l'enregistrement de la tenue",
        failed_to_load = "Échec du chargement de la tenue",
        failed_to_delete = "Échec de la suppression de la tenue",
        failed_to_edit = "Échec de la mise à jour de la tenue",
        invalid_name = "Nom de tenue invalide. Doit contenir entre 1 et 50 caractères",
        blocked_zone = "Vous ne pouvez pas changer de tenue dans cette zone",
        no_permission = "Vous n'avez pas la permission d'utiliser ceci",
    },
    menu = {
        outfit_bag = "Sac à Tenues",
        save_current = "Enregistrer la Tenue Actuelle",
        manage_outfits = "Gérer les Tenues",
        outfit_name = "Nom de la Tenue",
        save = "Enregistrer la Tenue",
        load = "Charger la Tenue",
        delete = "Supprimer la Tenue",
        access = "Accéder au Sac",
        pickup = "Ramasser le Sac",
        save_description = "Enregistrer votre tenue actuelle dans le sac",
        storage = "Stockage",
        action = "Action",
        save_action = "Enregistrer la tenue actuelle",
        note = "Note",
        save_note = "Entrez un nom unique pour votre tenue",
        save_title = "Enregistrer la Tenue",
        outfit_name_desc = "Donnez un nom mémorable à votre tenue",
        outfit_name_placeholder = "Ma Super Tenue",
        outfit_desc = "Description (Optionnel)",
        outfit_desc_desc = "Ajoutez des notes sur cette tenue",
        outfit_desc_placeholder = "Ma tenue décontractée préférée",
        no_description = "Pas de description",
        saved_on = "Enregistré le",
        unknown_date = "Date inconnue",
        actions_available = "Actions Disponibles",
        actions_hint = "Cliquez pour charger ou supprimer",
        load_description = "Mettre cette tenue",
        delete_description = "Supprimer cette tenue du sac",
        edit = "Modifier la Tenue",
        edit_title = "Modifier les Détails de la Tenue",
        edit_description = "Modifier le nom ou la description de cette tenue",
        no_outfits = "Aucune Tenue Enregistrée",
        no_outfits_desc = "Enregistrez votre première tenue en utilisant l'option ci-dessus"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 