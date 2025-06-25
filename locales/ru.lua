local Translations = {
    info = {
        bag_full = "В этой сумке может храниться только %{maxOutfits} комплектов одежды",
        changing_outfit = "Смена одежды...",
    },
    success = {
        outfit_saved = "Комплект сохранен в сумке: %{outfitName}",
        outfit_loaded = "Комплект загружен: %{outfitName}",
        outfit_deleted = "Комплект удален: %{outfitName}",
        outfit_edited = "Комплект обновлен: %{outfitName}",
    },
    error = {
        no_outfit_bag = "У вас нет сумки для одежды",
        outfit_not_found = "Комплект не найден",
        cannot_use_here = "Вы не можете использовать сумку для одежды здесь",
        failed_to_save = "Не удалось сохранить комплект",
        failed_to_load = "Не удалось загрузить комплект",
        failed_to_delete = "Не удалось удалить комплект",
        failed_to_edit = "Не удалось обновить комплект",
        invalid_name = "Неверное название комплекта. Должно быть от 1 до 50 символов",
        blocked_zone = "Вы не можете менять одежду в этой зоне",
        no_permission = "У вас нет разрешения на использование этого",
    },
    menu = {
        outfit_bag = "Сумка для Одежды",
        save_current = "Сохранить Текущий Комплект",
        manage_outfits = "Управление Комплектами",
        outfit_name = "Название Комплекта",
        save = "Сохранить Комплект",
        load = "Загрузить Комплект",
        delete = "Удалить Комплект",
        access = "Открыть Сумку",
        pickup = "Поднять Сумку",
        save_description = "Сохранить текущий комплект в сумке",
        storage = "Хранилище",
        action = "Действие",
        save_action = "Сохранить текущий комплект",
        note = "Заметка",
        save_note = "Введите уникальное название для вашего комплекта",
        save_title = "Сохранить Комплект",
        outfit_name_desc = "Дайте запоминающееся название вашему комплекту",
        outfit_name_placeholder = "Мой Крутой Комплект",
        outfit_desc = "Описание (Необязательно)",
        outfit_desc_desc = "Добавьте заметки к этому комплекту",
        outfit_desc_placeholder = "Моя любимая повседневная одежда",
        no_description = "Нет описания",
        saved_on = "Сохранено",
        unknown_date = "Неизвестная дата",
        actions_available = "Доступные Действия",
        actions_hint = "Нажмите для загрузки или удаления",
        load_description = "Надеть этот комплект",
        delete_description = "Удалить этот комплект из сумки",
        edit = "Редактировать Комплект",
        edit_title = "Редактировать Детали Комплекта",
        edit_description = "Изменить название или описание этого комплекта",
        no_outfits = "Нет Сохраненных Комплектов",
        no_outfits_desc = "Сохраните свой первый комплект, используя опцию выше"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 