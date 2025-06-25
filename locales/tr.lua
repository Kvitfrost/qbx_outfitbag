local Translations = {
    info = {
        bag_full = "Bu çanta sadece %{maxOutfits} kıyafet alabilir",
        changing_outfit = "Kıyafet değiştiriliyor...",
    },
    success = {
        outfit_saved = "Kıyafet çantaya kaydedildi: %{outfitName}",
        outfit_loaded = "Kıyafet yüklendi: %{outfitName}",
        outfit_deleted = "Kıyafet silindi: %{outfitName}",
        outfit_edited = "Kıyafet güncellendi: %{outfitName}",
    },
    error = {
        no_outfit_bag = "Kıyafet çantan yok",
        outfit_not_found = "Kıyafet bulunamadı",
        cannot_use_here = "Kıyafet çantasını burada kullanamazsın",
        failed_to_save = "Kıyafet kaydedilemedi",
        failed_to_load = "Kıyafet yüklenemedi",
        failed_to_delete = "Kıyafet silinemedi",
        failed_to_edit = "Kıyafet güncellenemedi",
        invalid_name = "Geçersiz kıyafet ismi. 1-50 karakter arasında olmalı",
        blocked_zone = "Bu bölgede kıyafet değiştiremezsin",
        no_permission = "Bunu kullanma yetkin yok",
    },
    menu = {
        outfit_bag = "Kıyafet Çantası",
        save_current = "Mevcut Kıyafeti Kaydet",
        manage_outfits = "Kıyafetleri Yönet",
        outfit_name = "Kıyafet İsmi",
        save = "Kıyafeti Kaydet",
        load = "Kıyafeti Yükle",
        delete = "Kıyafeti Sil",
        access = "Çantayı Aç",
        pickup = "Çantayı Al",
        save_description = "Mevcut kıyafetini çantaya kaydet",
        storage = "Depolama",
        action = "İşlem",
        save_action = "Mevcut kıyafeti kaydet",
        note = "Not",
        save_note = "Kıyafetin için benzersiz bir isim gir",
        save_title = "Kıyafeti Kaydet",
        outfit_name_desc = "Kıyafetine akılda kalıcı bir isim ver",
        outfit_name_placeholder = "Harika Kıyafetim",
        outfit_desc = "Açıklama (İsteğe Bağlı)",
        outfit_desc_desc = "Bu kıyafet için notlar ekle",
        outfit_desc_placeholder = "En sevdiğim günlük kıyafetim",
        no_description = "Açıklama yok",
        saved_on = "Kaydedilme",
        unknown_date = "Bilinmeyen tarih",
        actions_available = "Mevcut İşlemler",
        actions_hint = "Yüklemek veya silmek için tıkla",
        load_description = "Bu kıyafeti giy",
        delete_description = "Bu kıyafeti çantadan sil",
        edit = "Kıyafeti Düzenle",
        edit_title = "Kıyafet Detaylarını Düzenle",
        edit_description = "Bu kıyafetin ismini veya açıklamasını değiştir",
        no_outfits = "Kayıtlı Kıyafet Yok",
        no_outfits_desc = "Yukarıdaki seçeneği kullanarak ilk kıyafetini kaydet"
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
}) 