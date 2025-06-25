local Translations = {
    info = {
        bag_full = "Esta bolsa só pode conter %{maxOutfits} conjuntos",
        changing_outfit = "Trocando de roupa...",
    },
    success = {
        outfit_saved = "Conjunto salvo na bolsa: %{outfitName}",
        outfit_loaded = "Conjunto carregado: %{outfitName}",
        outfit_deleted = "Conjunto excluído: %{outfitName}",
        outfit_edited = "Conjunto atualizado: %{outfitName}",
    },
    error = {
        no_outfit_bag = "Você não tem uma bolsa de roupas",
        outfit_not_found = "Conjunto não encontrado",
        cannot_use_here = "Você não pode usar a bolsa de roupas aqui",
        failed_to_save = "Falha ao salvar o conjunto",
        failed_to_load = "Falha ao carregar o conjunto",
        failed_to_delete = "Falha ao excluir o conjunto",
        failed_to_edit = "Falha ao atualizar o conjunto",
        invalid_name = "Nome de conjunto inválido. Deve ter entre 1-50 caracteres",
        blocked_zone = "Você não pode trocar de roupa nesta área",
        no_permission = "Você não tem permissão para usar isso",
    },
    menu = {
        outfit_bag = "Bolsa de Roupas",
        save_current = "Salvar Conjunto Atual",
        manage_outfits = "Gerenciar Conjuntos",
        outfit_name = "Nome do Conjunto",
        save = "Salvar Conjunto",
        load = "Carregar Conjunto",
        delete = "Excluir Conjunto",
        access = "Acessar Bolsa",
        pickup = "Pegar Bolsa",
        save_description = "Guardar seu conjunto atual na bolsa",
        storage = "Armazenamento",
        action = "Ação",
        save_action = "Salvar conjunto atual",
        note = "Nota",
        save_note = "Digite um nome único para seu conjunto",
        save_title = "Salvar Conjunto",
        outfit_name_desc = "Dê um nome memorável ao seu conjunto",
        outfit_name_placeholder = "Meu Conjunto Incrível",
        outfit_desc = "Descrição (Opcional)",
        outfit_desc_desc = "Adicione notas sobre este conjunto",
        outfit_desc_placeholder = "Minha roupa casual favorita",
        no_description = "Sem descrição",
        saved_on = "Salvo em",
        unknown_date = "Data desconhecida",
        actions_available = "Ações Disponíveis",
        actions_hint = "Clique para carregar ou excluir",
        load_description = "Vestir este conjunto",
        delete_description = "Remover este conjunto da bolsa",
        edit = "Editar Conjunto",
        edit_title = "Editar Detalhes do Conjunto",
        edit_description = "Alterar o nome ou descrição deste conjunto",
        no_outfits = "Nenhum Conjunto Salvo",
        no_outfits_desc = "Salve seu primeiro conjunto usando a opção acima"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 