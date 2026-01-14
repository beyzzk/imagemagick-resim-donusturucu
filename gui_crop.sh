#!/bin/bash

source ./fonksiyonlar.sh

# Resim seç
giris=$(yad --file \
    --title="Resim Seç (Kırpma)" \
    --file-filter="Resimler | *.jpg *.jpeg *.png *.webp")

[ -z "$giris" ] && exit 0

# Şematik + açıklamalı crop formu
degerler=$(yad --form \
    --width=550 \
    --height=460 \
    --title="✂️ Kırpma (Crop) Ayarları" \
    --text="Aşağıdaki şema, kırpma işleminin nasıl çalıştığını gösterir:\n
<tt>
(0,0)
 ┌───────────────────────────┐
 │                           │
 │   ┌───────────────┐       │
 │   │   KIRPILAN     │       │
 │   │     ALAN       │       │
 │   └───────────────┘       │
 │                           │
 └───────────────────────────┘
        → X        ↓ Y
</tt>\n
<b>Açıklamalar:</b>\n
• <b>Genişlik / Yükseklik</b>: Kırpılacak alanın boyutu\n
• <b>X</b>: Soldan kaç piksel içeriden başlasın\n
• <b>Y</b>: Üstten kaç piksel içeriden başlasın\n\n
<b>Örnek:</b>\n
300 x 200 + X:0 + Y:0 → Sol üstten kırpar." \
    --field="Genişlik (px):" "300" \
    --field="Yükseklik (px):" "200" \
    --field="X Başlangıç (px):" "0" \
    --field="Y Başlangıç (px):" "0")

[ $? -ne 0 ] && exit 0

IFS="|" read -r gen yuk x y <<< "$degerler"

# Boş alan kontrolü
if [ -z "$gen" ] || [ -z "$yuk" ] || [ -z "$x" ] || [ -z "$y" ]; then
    yad --error \
        --title="Hata" \
        --text="Tüm alanlar doldurulmalıdır."
    exit 0
fi

# Sayısal kontrol
if ! [[ "$gen" =~ ^[0-9]+$ && "$yuk" =~ ^[0-9]+$ && "$x" =~ ^[0-9]+$ && "$y" =~ ^[0-9]+$ ]]; then
    yad --error \
        --title="Hata" \
        --text="Tüm değerler pozitif tam sayı olmalıdır."
    exit 0
fi

# Çıkış dosyası
cikis="${giris%.*}_crop.${giris##*.}"

# Crop işlemi
crop_image "$giris" "$cikis" "$gen" "$yuk" "$x" "$y"

if [ $? -eq 0 ]; then
    yad --info \
        --title="Başarılı" \
        --text="Kırpma işlemi tamamlandı 🎉\n\nOluşturulan dosya:\n<b>$cikis</b>"
else
    yad --error \
        --title="Hata" \
        --text="Kırpma sırasında bir hata oluştu."
fi

