#!/bin/bash

source ./fonksiyonlar.sh

# Resim seç
giris=$(yad --file \
    --title="Resim Seç (Boyutlandırma)" \
    --file-filter="Resimler | *.jpg *.jpeg *.png *.webp")

[ -z "$giris" ] && exit 0

# Boyut al (zorunlu)
boyut=$(yad --entry \
    --width=350 \
    --title="Boyutlandırma" \
    --text="Yeni boyutu girin:\nÖrnek: 800x600")

# Boş girilirse uyar
if [ -z "$boyut" ]; then
    yad --warning \
        --title="Uyarı" \
        --text="Boyut boş bırakılamaz."
    exit 0
fi

# Boyut formatı kontrolü (basit)
if ! [[ "$boyut" =~ ^[0-9]+x[0-9]+$ ]]; then
    yad --error \
        --title="Hata" \
        --text="Geçersiz boyut formatı!\nÖrnek: 800x600"
    exit 0
fi

# Çıkış dosyası adı
cikis="${giris%.*}_resize.${giris##*.}"

# Boyutlandır
convert_image "$giris" "$cikis" "$boyut"

if [ $? -eq 0 ]; then
    yad --info \
        --title="Başarılı" \
        --text="Boyutlandırma tamamlandı 🎉\n\nOluşturulan dosya:\n<b>$cikis</b>"
else
    yad --error \
        --title="Hata" \
        --text="Boyutlandırma sırasında hata oluştu."
fi
