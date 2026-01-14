#!/bin/bash

source ./fonksiyonlar.sh

# Resim seç
giris=$(yad --file \
    --title="Resim Seç (Çözünürlük Değiştirme)" \
    --file-filter="Resimler | *.jpg *.jpeg *.png *.webp")

[ -z "$giris" ] && exit 0

# DPI giriş ekranı
dpi=$(yad --entry \
    --width=450 \
    --height=300 \
    --title="🖨️ Çözünürlük (DPI) Ayarı" \
    --text="<b>Çözünürlük (DPI) Nedir?</b>\n
DPI, bir inçteki piksel sayısını ifade eder.\n
Bu işlem resmin boyutunu değil, baskı kalitesini değiştirir.\n\n
<b>Yaygın DPI Değerleri:</b>\n
• 72  → Ekran / Web\n
• 150 → Orta kalite\n
• 300 → Baskı (Print)\n\n
<b>Örnek:</b>\n300 DPI → Yüksek baskı kalitesi" \
    --entry-text="300")

[ -z "$dpi" ] && exit 0

# Sayısal kontrol
if ! [[ "$dpi" =~ ^[0-9]+$ ]]; then
    yad --error \
        --title="Hata" \
        --text="DPI değeri pozitif bir sayı olmalıdır."
    exit 0
fi

# Çıkış dosyası
cikis="${giris%.*}_dpi${dpi}.${giris##*.}"

# Resolution işlemi
resolution_image "$giris" "$cikis" "$dpi"

if [ $? -eq 0 ]; then
    yad --info \
        --title="Başarılı" \
        --text="Çözünürlük ayarlandı 🎉\n\nYeni dosya:\n<b>$cikis</b>"
else
    yad --error \
        --title="Hata" \
        --text="Çözünürlük değiştirme sırasında hata oluştu."
fi
