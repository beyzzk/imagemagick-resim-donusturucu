#!/bin/bash

source ./fonksiyonlar.sh

while true; do

SECIM=$(whiptail --title "Fotoğraf İşleme Aracı (TUI)" \
--menu "Yapmak istediğiniz işlemi seçin:" 20 60 10 \
"1" "Format Değiştirme (jpg ↔ png ↔ webp)" \
"2" "Boyutlandırma (Resize)" \
"3" "Çözünürlük (DPI)" \
"4" "Döndürme (Rotate)" \
"5" "Kırpma (Crop)" \
"0" "Çıkış" \
3>&1 1>&2 2>&3)

[ $? -ne 0 ] && exit 0

case "$SECIM" in

# ================= FORMAT =================
1)
    giris=$(whiptail --inputbox "Dönüştürülecek resmin yolunu girin:" 10 60 3>&1 1>&2 2>&3)
    [ -z "$giris" ] && continue

    hedef=$(whiptail --menu "Hedef formatı seçin:" 15 60 5 \
    "png" "PNG formatı" \
    "jpg" "JPG formatı" \
    "jpeg" "JPEG formatı" \
    "webp" "WEBP formatı" \
    3>&1 1>&2 2>&3)

    [ -z "$hedef" ] && continue

    cikis="${giris%.*}.$hedef"
    convert_image "$giris" "$cikis" ""

    whiptail --msgbox "Dönüştürme tamamlandı.\n$cikis" 10 60
;;

# ================= RESIZE =================
2)
    giris=$(whiptail --inputbox "Resim dosya yolu:" 10 60 3>&1 1>&2 2>&3)
    [ -z "$giris" ] && continue

    boyut=$(whiptail --inputbox "Yeni boyut (örn: 800x600):" 10 60 3>&1 1>&2 2>&3)
    [ -z "$boyut" ] && continue

    cikis="${giris%.*}_resize.${giris##*.}"
    convert_image "$giris" "$cikis" "$boyut"

    whiptail --msgbox "Boyutlandırma tamamlandı.\n$cikis" 10 60
;;

# ================= DPI =================
3)
    giris=$(whiptail --inputbox "Resim dosya yolu:" 10 60 3>&1 1>&2 2>&3)
    [ -z "$giris" ] && continue

    dpi=$(whiptail --inputbox "DPI değeri (72 / 150 / 300):" 10 60 3>&1 1>&2 2>&3)
    [ -z "$dpi" ] && continue

    cikis="${giris%.*}_dpi${dpi}.${giris##*.}"
    resolution_image "$giris" "$cikis" "$dpi"

    whiptail --msgbox "Çözünürlük ayarlandı.\n$cikis" 10 60
;;

# ================= ROTATE =================
4)
    giris=$(whiptail --inputbox "Resim dosya yolu:" 10 60 3>&1 1>&2 2>&3)
    [ -z "$giris" ] && continue

    aci=$(whiptail --menu "Döndürme açısı:" 15 60 5 \
    "90" "Saat yönünde 90°" \
    "180" "180°" \
    "270" "Saat yönünün tersine 90°" \
    3>&1 1>&2 2>&3)

    [ -z "$aci" ] && continue

    cikis="${giris%.*}_rotate${aci}.${giris##*.}"
    rotate_image "$giris" "$cikis" "$aci"

    whiptail --msgbox "Döndürme tamamlandı.\n$cikis" 10 60
;;

# ================= CROP =================
5)
    giris=$(whiptail --inputbox "Resim dosya yolu:" 10 60 3>&1 1>&2 2>&3)
    [ -z "$giris" ] && continue

    gen=$(whiptail --inputbox "Genişlik (px):" 10 60 3>&1 1>&2 2>&3)
    yuk=$(whiptail --inputbox "Yükseklik (px):" 10 60 3>&1 1>&2 2>&3)
    x=$(whiptail --inputbox "X başlangıç (px):" 10 60 3>&1 1>&2 2>&3)
    y=$(whiptail --inputbox "Y başlangıç (px):" 10 60 3>&1 1>&2 2>&3)

    cikis="${giris%.*}_crop.${giris##*.}"
    crop_image "$giris" "$cikis" "$gen" "$yuk" "$x" "$y"

    whiptail --msgbox "Kırpma tamamlandı.\n$cikis" 10 60
;;

0)
    exit 0
;;

esac
done
