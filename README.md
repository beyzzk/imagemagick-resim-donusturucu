# Fotoğraf Dönüştürme ve İşleme Aracı

Bu proje, Linux işletim sistemleri için geliştirilmiş,
komut satırı (TUI) ve grafik arayüz (GUI) destekli bir fotoğraf işleme uygulamasıdır.

Proje Pardus ortamında geliştirilmiştir ve burada çalıştırılabilir.

Proje, **Bash Script**, **ImageMagick**, **YAD** ve **whiptail** kullanılarak geliştirilmiştir.

---

## 🚀 Özellikler

Uygulamada aşağıdaki fotoğraf işlemlerini yapabilirsiniz:

- 📁 Format dönüştürme (JPG, JPEG, PNG, WEBP)
- 📐 Boyutlandırma (Resize)
- 🖨️ Çözünürlük (DPI) değiştirme
- 🔄 Döndürme (Rotate)
- ✂️ Kırpma (Crop)

Her işlem, kullanıcıdan gerekli parametreleri alır ve
orijinal dosyayı bozmadan **aynı klasörde işlemin uygulandığı yeni bir dosya oluşturur**.

---

## 🖥️ Arayüzler

### GUI (Grafik Arayüz)
- **YAD** kullanılarak geliştirilmiştir.
- Kullanıcıyı yönlendiren pencereler bulunur.
- Görsel kullanıcılar için uygundur.

### TUI (Metin Tabanlı Arayüz)
- **Whiptail** ile oluşturulmuştur.
- Terminal odaklı kullanıcılar için uygundur.
- Menü tabanlı ve etkileşimlidir.

---

## 🛠️ Kullanılan Teknolojiler

- Bash Script
- ImageMagick
- YAD
- Whiptail
- Linux (Pardus)

---

## 🔧 Sistem Gereksinimleri

Bu uygulamanın çalışabilmesi için aşağıdaki gereksinimlerin sağlanması gerekir:

### İşletim Sistemi
- Linux (Pardus önerilir)
- Debian / Ubuntu tabanlı dağıtımlar

### Gerekli Paketler
- **bash**
- **imagemagick** (resim işleme işlemleri için)
- **yad** (grafik arayüz için)
- **whiptail** (metin tabanlı arayüz için)
- **git** (projeyi GitHub’dan indirmek için)


## 📂 Dosya Yapısı

resim-donusturucu/  
├── gui.sh  
├── gui_crop.sh  
├── gui_resize.sh  
├── gui_rotate.sh  
├── gui_resolution.sh  
├── tui.sh  
├── fonksiyonlar.sh  
└── README.md  

## 📥 GitHub’dan Kurulum ve Çalıştırma

Aşağıdaki adımlar, projeyi GitHub üzerinden indirip çalıştırmak için uygulanması gereken adımlardır.

### 1)Depoyu Klonlayın

Terminali açarak aşağıdaki komutu çalıştırın:

```bash
git clone https://github.com/beyzzk/imagemagick-resim-donusturucu.git
```

### 2)Klasöre girin
```cd resim-donusturucu
```

### 3)Gerekli paketleri kurun
```sudo apt update
sudo apt install imagemagick yad whiptail git -y
```
### 4)Çalıştırma izinlerini verin
```chmod +x gui.sh tui.sh
```

### 5)Uygulamayı başlatın
```
./gui.sh
./tui.sh
```
