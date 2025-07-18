local Translations = {
    info = {
        bag_full = "В этой сумке может храниться только %{maxOutfits} комплектов одежды",
        changing_outfit = "Смена одежды...",
        animation_failed = "Не удалось загрузить анимацию",
        placing_bag = "Размещение сумки...",
        picking_up_bag = "Поднятие сумки..."
    },
    success = {
        outfit_saved = "Комплект одежды сохранен в сумке: %{outfitName}",
        outfit_loaded = "Комплект одежды загружен: %{outfitName}",
        outfit_deleted = "Комплект одежды удален: %{outfitName}",
        outfit_edited = "Комплект одежды обновлен: %{outfitName}",
        outfit_shared_sender = "Комплект одежды отправлен: %{outfitName}",
        outfit_shared_receiver = "Получен комплект одежды: %{outfitName}",
    },
    error = {
        no_outfit_bag = "У вас нет сумки для одежды",
        outfit_not_found = "Комплект одежды не найден",
        failed_to_save = "Не удалось сохранить комплект одежды",
        failed_to_load = "Не удалось загрузить комплект одежды",
        failed_to_delete = "Не удалось удалить комплект одежды",
        failed_to_edit = "Не удалось обновить комплект одежды",
        failed_to_share = "Не удалось поделиться комплектом одежды",
        invalid_name = "Недопустимое название комплекта. Должно быть от 1 до 50 символов",
        no_permission = "У вас нет разрешения на использование этого",
        prop_load_failed = "Не удалось загрузить модель сумки",
        prop_spawn_failed = "Не удалось создать сумку",
        no_players_nearby = "Нет игроков поблизости для обмена",
        target_not_found = "Целевой игрок не найден",
        target_no_outfit_bag = "У целевого игрока нет сумки для одежды",
        target_bag_full = "Сумка целевого игрока полна",
        not_your_bag = "Это не ваша сумка для одежды",
        no_bag = "У вас нет сумки для одежды",
        animation_failed = "Не удалось воспроизвести анимацию",
    },
    menu = {
        outfit_bag = "Сумка для Одежды",
        save_current = "Сохранить Текущий Комплект",
        manage_outfits = "Управление Комплектами",
        outfit_name = "Название Комплекта",
        save = "Сохранить Комплект",
        load = "Загрузить Комплект",
        delete = "Удалить Комплект",
        share = "Поделиться Комплектом",
        share_description = "Поделиться этим комплектом с ближайшим игроком",
        share_with = "Поделиться с Игроком",
        player_id = "ID Игрока: %{playerId}",
        player_distance = "%{distance} метров",
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
        actions_hint = "Нажмите для загрузки, редактирования, обмена или удаления",
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