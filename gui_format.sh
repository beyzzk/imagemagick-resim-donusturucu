#!/bin/bash

source ./fonksiyonlar.sh

# Kaynak format seçimi
kaynak=$(yad --width=400 --height=250 \
    --title="Format Değiştirme" \
    --text="<b>Kaynak formatı seçin</b>" \
    --list \
    --column="Format" \
    "jpg" \
    "jpeg" \
    "png" \
    "webp" \
    --button="İleri":0 \
    --button="İptal":1)

[ $? -ne 0 ] && exit 0

kaynak_format=$(echo "$kaynak" | tr -d '|')

# Hedef format seçimi
hedef=$(yad --width=400 --height=250 \
    --title="Format Değiştirme" \
    --text="<b>Hedef formatı seçin</b>" \
    --list \
    --column="Format" \
    "jpg" \
    "jpeg" \
    "png" \
    "webp" \
    --button="Dönüştür":0 \
    --button="İptal":1)

[ $? -ne 0 ] && exit 0

hedef_format=$(echo "$hedef" | tr -d '|')

# Aynı format kontrolü
if [ "$kaynak_format" = "$hedef_format" ]; then
    yad --warning \
        --title="Uyarı" \
        --text="Kaynak ve hedef format aynı olamaz."
    exit 0
fi

# Resim seç
giris=$(yad --file \
    --title="Resim Seç" \
    --file-filter="Resimler | *.jpg *.jpeg *.png *.webp")

[ -z "$giris" ] && exit 0

# Boyut (opsiyonel)
boyut=$(yad --entry \
    --width=350 \
    --title="Boyutlandırma (Opsiyonel)" \
    --text="Yeni boyutu girin (örnek: 800x600)\nBoş bırakırsanız sadece format dönüştürülür.")

# Çıkış dosyası (aynı klasör)
cikis="${giris%.*}.$hedef_format"

# Dönüştür
convert_image "$giris" "$cikis" "$boyut"

if [ $? -eq 0 ]; then
    yad --info \
        --title="Başarılı" \
        --text="Dönüştürme tamamlandı 🎉\n\nOluşturulan dosya:\n<b>$cikis</b>"
else
    yad --error \
        --title="Hata" \
        --text="Dönüştürme sırasında hata oluştu."
fi
