local Translations = {
    info = {
        bag_full = "Esta bolsa solo puede contener %{maxOutfits} conjuntos",
        changing_outfit = "Cambiando conjunto...",
    },
    success = {
        outfit_saved = "Conjunto guardado en la bolsa: %{outfitName}",
        outfit_loaded = "Conjunto cargado: %{outfitName}",
        outfit_deleted = "Conjunto eliminado: %{outfitName}",
        outfit_edited = "Conjunto actualizado: %{outfitName}",
    },
    error = {
        no_outfit_bag = "No tienes una bolsa de conjuntos",
        outfit_not_found = "Conjunto no encontrado",
        cannot_use_here = "No puedes usar la bolsa de conjuntos aquí",
        failed_to_save = "Error al guardar el conjunto",
        failed_to_load = "Error al cargar el conjunto",
        failed_to_delete = "Error al eliminar el conjunto",
        failed_to_edit = "Error al actualizar el conjunto",
        invalid_name = "Nombre de conjunto inválido. Debe tener entre 1-50 caracteres",
        blocked_zone = "No puedes cambiar de conjunto en esta área",
        no_permission = "No tienes permiso para usar esto",
    },
    menu = {
        outfit_bag = "Bolsa de Conjuntos",
        save_current = "Guardar Conjunto Actual",
        manage_outfits = "Gestionar Conjuntos",
        outfit_name = "Nombre del Conjunto",
        save = "Guardar Conjunto",
        load = "Cargar Conjunto",
        delete = "Eliminar Conjunto",
        access = "Acceder a la Bolsa",
        pickup = "Recoger Bolsa",
        save_description = "Guardar tu conjunto actual en la bolsa",
        storage = "Almacenamiento",
        action = "Acción",
        save_action = "Guardar conjunto actual",
        note = "Nota",
        save_note = "Introduce un nombre único para tu conjunto",
        save_title = "Guardar Conjunto",
        outfit_name_desc = "Dale un nombre memorable a tu conjunto",
        outfit_name_placeholder = "Mi Conjunto Genial",
        outfit_desc = "Descripción (Opcional)",
        outfit_desc_desc = "Añade notas sobre este conjunto",
        outfit_desc_placeholder = "Mi ropa casual favorita",
        no_description = "Sin descripción",
        saved_on = "Guardado el",
        unknown_date = "Fecha desconocida",
        actions_available = "Acciones Disponibles",
        actions_hint = "Clic para cargar o eliminar",
        load_description = "Cambiar a este conjunto",
        delete_description = "Eliminar este conjunto de la bolsa",
        edit = "Editar Conjunto",
        edit_title = "Editar Detalles del Conjunto",
        edit_description = "Cambiar el nombre o descripción de este conjunto",
        no_outfits = "Sin Conjuntos Guardados",
        no_outfits_desc = "Guarda tu primer conjunto usando la opción de arriba"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 