#!/bin/bash
#Resim donusturme fonksiyonu(jpg-png-webp)
#İsteğe bağlı olarak boyut değiştirme de yapar
#parametreler :
#1.Giriş dosyası
#2.Çıkış dosyası
#3.Boyut

convert_image() {
    local input_file="$1"
    local output_file="$2"
    local resize_value="$3"

    if [ ! -f "$input_file" ]; then
        return 1
    fi

    if [ -n "$resize_value" ]; then
        convert "$input_file" -resize "$resize_value" "$output_file"
    else
        convert "$input_file" "$output_file"
    fi

    return 0
}

rotate_image() {
    giris="$1"
    cikis="$2"
    aci="$3"

    convert "$giris" -rotate "$aci" "$cikis"
}

crop_image() {
    giris="$1"
    cikis="$2"
    gen="$3"
    yuk="$4"
    x="$5"
    y="$6"

    convert "$giris" -crop "${gen}x${yuk}+${x}+${y}" "$cikis"
}

resolution_image() {
    giris="$1"
    cikis="$2"
    dpi="$3"

    convert "$giris" -units PixelsPerInch -density "$dpi" "$cikis"
}
