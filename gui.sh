#!/bin/bash

while true; do
    secim=$(yad --width=500 --height=350 \
        --title="Fotoğraf Dönüştürme Aracı" \
        --text="<b>📷 Fotoğraf Dönüştürme Aracı</b>\n\nLütfen yapmak istediğiniz işlemi seçin:" \
        --list \
        --column="İşlem" --column="Açıklama" \
        "Format Değiştirme" "jpg → png, png → webp vb." \
        "Boyutlandırma" "Genişlik x Yükseklik (800x600)" \
        "Çözünürlük Değiştirme" "DPI ayarlama" \
        "Döndürme" "90°, 180°, 270°" \
        "Kırpma" "Belirli alanı kesme" \
        --separator="|" \
        --button="✔ Seç":0 \
        --button="❌ Çıkış":1)

    durum=$?

    [ "$durum" -ne 0 ] && exit 0
    [ -z "$secim" ] && continue

    islem=$(echo "$secim" | cut -d"|" -f1)

    case "$islem" in
        "Format Değiştirme")
            ./gui_format.sh
            ;;
        "Boyutlandırma")
            ./gui_resize.sh
            ;;
        "Çözünürlük Değiştirme")
            ./gui_resolution.sh
            ;;
        "Döndürme")
            ./gui_rotate.sh
            ;;
        "Kırpma")
            ./gui_crop.sh
            ;;
        *)
            exit 0
            ;;
    esac
done
