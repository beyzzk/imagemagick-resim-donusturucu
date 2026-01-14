#!/bin/bash

source ./fonksiyonlar.sh

# Resim seç
giris=$(yad --file \
    --title="Resim Seç (Döndürme)" \
    --file-filter="Resimler | *.jpg *.jpeg *.png *.webp")

[ -z "$giris" ] && exit 0

# Döndürme açısı seç
yad --width=400 --height=250 \
    --title="Döndürme Açısı" \
    --text="<b>Döndürme açısını seçin</b>" \
    --button="↩️ 90°":90 \
    --button="🔄 180°":180 \
    --button="↪️ 270°":270 \
    --button="❌ İptal":0

secim=$?

[ "$secim" -eq 0 ] && exit 0

case "$secim" in
    90) aci=90 ;;
    180) aci=180 ;;
    270) aci=270 ;;
    *) exit 0 ;;
esac

# Çıkış dosyası adı
cikis="${giris%.*}_rotate${aci}.${giris##*.}"

# Döndürme işlemi
rotate_image "$giris" "$cikis" "$aci"

if [ $? -eq 0 ]; then
    yad --info \
        --title="Başarılı" \
        --text="Döndürme tamamlandı 🎉\n\nOluşturulan dosya:\n<b>$cikis</b>"
else
    yad --error \
        --title="Hata" \
        --text="Döndürme sırasında hata oluştu."
fi
