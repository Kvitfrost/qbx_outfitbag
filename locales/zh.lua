local Translations = {
    info = {
        bag_full = "这个包只能存储 %{maxOutfits} 套装扮",
        changing_outfit = "正在更换装扮...",
    },
    success = {
        outfit_saved = "装扮已保存到包中：%{outfitName}",
        outfit_loaded = "已加载装扮：%{outfitName}",
        outfit_deleted = "已删除装扮：%{outfitName}",
        outfit_edited = "已更新装扮：%{outfitName}",
    },
    error = {
        no_outfit_bag = "你没有装扮包",
        outfit_not_found = "未找到装扮",
        cannot_use_here = "你不能在这里使用装扮包",
        failed_to_save = "保存装扮失败",
        failed_to_load = "加载装扮失败",
        failed_to_delete = "删除装扮失败",
        failed_to_edit = "更新装扮失败",
        invalid_name = "无效的装扮名称。必须在1-50个字符之间",
        blocked_zone = "你不能在这个区域更换装扮",
        no_permission = "你没有权限使用这个",
    },
    menu = {
        outfit_bag = "装扮包",
        save_current = "保存当前装扮",
        manage_outfits = "管理装扮",
        outfit_name = "装扮名称",
        save = "保存装扮",
        load = "加载装扮",
        delete = "删除装扮",
        access = "打开包",
        pickup = "拾取包",
        save_description = "将当前装扮保存到包中",
        storage = "存储",
        action = "操作",
        save_action = "保存当前装扮",
        note = "备注",
        save_note = "为你的装扮输入一个独特的名称",
        save_title = "保存装扮",
        outfit_name_desc = "给你的装扮一个容易记住的名称",
        outfit_name_placeholder = "我的酷炫装扮",
        outfit_desc = "描述（可选）",
        outfit_desc_desc = "为这个装扮添加备注",
        outfit_desc_placeholder = "我最喜欢的日常装扮",
        no_description = "无描述",
        saved_on = "保存于",
        unknown_date = "未知日期",
        actions_available = "可用操作",
        actions_hint = "点击加载或删除",
        load_description = "穿上这套装扮",
        delete_description = "从包中删除这套装扮",
        edit = "编辑装扮",
        edit_title = "编辑装扮详情",
        edit_description = "更改这套装扮的名称或描述",
        no_outfits = "没有保存的装扮",
        no_outfits_desc = "使用上面的选项保存你的第一套装扮"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 