# Yocto Project Kapsamlı Dokümantasyon

## 📚 İçindekiler

1. Giriş ve Genel Bakış
2. Kurulum ve İlk Ayarlar
3. Temel Kavramlar
4. Recipe (Tarif) Yazma
5. Layer Yönetimi
6. BSP ve Makine Konfigürasyonu
7. İmaj Oluşturma ve Özelleştirme
8. SDK ve Cross-Compilation
9. Hata Ayıklama ve Araçlar
10. İleri Seviye Konular

---

## 🌟 Giriş ve Genel Bakış

### Tarihçe
```
OpenEmbedded → Poky → Yocto Project
```

Yocto Project, gömülü Linux dağıtımları oluşturmak için kullanılan açık kaynak bir projedir. Linux Foundation tarafından desteklenir ve modüler bir yapıya sahiptir.

### Temel Prensipleri
- **Git tabanlı**: Tüm kod ve konfigürasyonlar git ile yönetilir
- **Modüler**: Layer (katman) sistemi ile esnek yapı
- **Sıfırdan inşa**: Toolchain'den başlayarak tüm sistemi derler
- **Çoklu mimari**: ARM, x86, MIPS gibi farklı mimarileri destekler

---

## 🛠️ Kurulum ve İlk Ayarlar

### Sistem Gereksinimleri

````bash
# Ubuntu/Debian için gerekli paketler
sudo apt update && sudo apt upgrade -y
sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential \
chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils \
iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file \
locales libacl1 -y
````

### Distrobox ile İzole Ortam Kurulumu

````bash
# Yocto için özel bir distrobox container oluşturma
distrobox-create --image ubuntu:22.04 --name yocto_proj --home /home/user/projelerimiz3/yocto_proje/

# Container'a giriş
distrobox enter yocto_proj
````

### Kernel Ayarları

````bash
# Unprivileged user namespaces için
echo "kernel.apparmor_restrict_unprivileged_userns = 0" | sudo tee /etc/sysctl.d/99-unprivileged-userns.conf
sudo sysctl --system
````

### Yocto Proje Yapısını İndirme

````bash
# Ana dizin oluşturma
mkdir -p ~/yocto-workspace
cd ~/yocto-workspace

# Poky ana repository'sini klonlama
git clone -b kirkstone https://git.yoctoproject.org/poky
cd poky

# Meta-arm layer'ı ekleme (ARM desteği için)
git clone -b kirkstone https://github.com/meta-arm/meta-arm.git

# Meta-ti layer'ı ekleme (TI işlemci desteği için)
git clone -b kirkstone https://github.com/TexasInstruments/meta-ti.git
````

### İlk Build Ortamı Kurulumu

````bash
# Build ortamını kaynak alma
source oe-init-build-env build

# Bblayers.conf düzenleme
cat >> conf/bblayers.conf << 'EOF'
BBLAYERS += " \
  /home/user/yocto-workspace/poky/meta-arm/meta-arm \
  /home/user/yocto-workspace/poky/meta-arm/meta-arm-toolchain \
  /home/user/yocto-workspace/poky/meta-ti/meta-ti-bsp \
  "
EOF
````

### local.conf Temel Ayarları

````bash
# local.conf dosyasına eklenmesi gereken ayarlar
cat >> conf/local.conf << 'EOF'
# Makine seçimi
MACHINE = "qemuarm64"

# Paralel iş sayısı (CPU çekirdek sayısına göre ayarlayın)
BB_NUMBER_THREADS = "8"
PARALLEL_MAKE = "-j 8"

# Disk alanı tasarrufu
INHERIT += "rm_work"

# Paket yöneticisi
PACKAGE_CLASSES = "package_ipk"

# Shared state ve download dizinleri
DL_DIR = "/mnt/shared/downloads"
SSTATE_DIR = "/mnt/shared/sstate-cache"

# Hash equivalence ve shared state mirrors
BB_HASHSERVE_UPSTREAM = "wss://hashserv.yoctoproject.org/ws"
SSTATE_MIRRORS ?= "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH"
BB_HASHSERVE = "auto"
BB_SIGNATURE_HANDLER = "OEEquivHash"
EOF
````

---

## 📖 Temel Kavramlar

### Değişken Türleri ve Kullanımı

#### Atama Operatörleri

````bash
# Basit atama
VARIABLE = "value"

# Derhal genişletme (immediate expansion)
VARIABLE := "value"

# Conditional atama (eğer tanımlı değilse)
VARIABLE ?= "default_value"

# Ekleme operatörleri
VARIABLE += "append_with_space"
VARIABLE =+ "prepend_with_space"
VARIABLE .= "append_without_space"
VARIABLE =. "prepend_without_space"
````

#### Override Sistemi

````bash
# Makine özel override
KERNEL_DEVICETREE:beaglebone = "am335x-bone.dtb"

# Distro özel override
PREFERRED_PROVIDER_virtual/kernel:poky = "linux-yocto"

# Koşullu override
OVERRIDES = "arm:armv7a:ti-soc:ti33x:beaglebone:poky"
````

### Önemli Dizinler ve Değişkenler

| Değişken | Açıklama |
|----------|----------|
| `${WORKDIR}` | Geçici çalışma dizini |
| `${S}` | Kaynak kod dizini |
| `${D}` | Hedef kurulum dizini |
| `${B}` | Build dizini |
| `${PN}` | Package Name (paket adı) |
| `${PV}` | Package Version (paket versiyonu) |
| `${PR}` | Package Revision (paket revizyonu) |

---

## 📝 Recipe (Tarif) Yazma

### Temel Recipe Yapısı

````bitbake
SUMMARY = "Simple Hello World application"
DESCRIPTION = "A simple application that prints Hello World"
HOMEPAGE = "https://github.com/example/hello"
SECTION = "examples"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=..."

SRC_URI = "git://github.com/example/hello.git;protocol=https;branch=main"
SRCREV = "v1.0"

S = "${WORKDIR}/git"

inherit autotools

do_install() {
    install -d ${D}${bindir}
    install -m 0755 hello ${D}${bindir}
}

FILES:${PN} = "${bindir}/hello"
````

### Recipe İnherit Sistemleri

#### Autotools Projesi

````bitbake
inherit autotools

EXTRA_OECONF = "--enable-feature1 --disable-feature2"
````

#### CMake Projesi

````bitbake
inherit cmake

EXTRA_OECMAKE = "-DCMAKE_BUILD_TYPE=Release -DENABLE_FEATURE=ON"
````

#### Python Paketi

````bitbake
inherit setuptools3

RDEPENDS:${PN} = "python3-core python3-modules"
````

### Gelişmiş Recipe Özellikleri

#### PACKAGECONFIG Kullanımı

````bitbake
PACKAGECONFIG ??= "ssl zlib"
PACKAGECONFIG[ssl] = "--enable-ssl,--disable-ssl,openssl"
PACKAGECONFIG[zlib] = "--enable-zlib,--disable-zlib,zlib"
````

#### Alt Paket Oluşturma

````bitbake
PACKAGES = "${PN} ${PN}-dev ${PN}-doc ${PN}-dbg"

FILES:${PN} = "${bindir}/* ${libdir}/lib*.so.*"
FILES:${PN}-dev = "${includedir}/* ${libdir}/lib*.so ${libdir}/*.la"
FILES:${PN}-doc = "${datadir}/doc/* ${mandir}/*"
````

---

## 🏗️ Layer Yönetimi

### Yeni Layer Oluşturma

````bash
# Layer oluşturma
bitbake-layers create-layer -p 7 meta-custom
bitbake-layers add-layer meta-custom

# Layer yapısı kontrol etme
bitbake-layers show-layers
````

### Layer.conf Örneği

````bitbake
# We have a conf and classes directory, add to BBPATH
BBPATH .= ":${LAYERDIR}"

# We have recipes-* directories, add to BBFILES
BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
            ${LAYERDIR}/recipes-*/*/*.bbappend"

BBFILE_COLLECTIONS += "meta-custom"
BBFILE_PATTERN_meta-custom = "^${LAYERDIR}/"
BBFILE_PRIORITY_meta-custom = "7"

LAYERDEPENDS_meta-custom = "core"
LAYERSERIES_COMPAT_meta-custom = "kirkstone"
````

### BBAppend Dosyaları

````bitbake
-kernel/linux/linux-yocto_%.bbappend
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://custom.cfg \
            file://custom-feature.patch \
           "

# Kernel konfigürasyon parçası ekleme
KERNEL_FEATURES:append = " custom/custom.scc"
````

---

## ⚙️ BSP ve Makine Konfigürasyonu

### Makine Konfigürasyon Dosyası

````bitbake
#@TYPE: Machine
#@NAME: Custom Development Board
#@SOC: Custom SoC
#@DESCRIPTION: Machine configuration for custom development board

MACHINEOVERRIDES =. "custom-board:"

require conf/machine/include/custom-soc.inc

PREFERRED_PROVIDER_virtual/kernel ?= "linux-custom"
PREFERRED_VERSION_linux-custom ?= "5.4%"

KERNEL_IMAGETYPE = "zImage"
KERNEL_DEVICETREE = "custom-board.dtb"

SERIAL_CONSOLES = "115200;ttyS0"

MACHINE_FEATURES = "usbgadget usbhost vfat ext2 screen touchscreen wifi bluetooth"

IMAGE_FSTYPES += "tar.bz2 ext4 wic"

WKS_FILE = "custom-board.wks"
````

### SoC Include Dosyası

````bitbake
SOC_FAMILY = "custom-soc"
MACHINEOVERRIDES =. "${SOC_FAMILY}:"

DEFAULTTUNE ?= "cortexa9hf-neon"
require conf/machine/include/tune-cortexa9.inc

PREFERRED_PROVIDER_virtual/bootloader = "u-boot-custom"
PREFERRED_PROVIDER_u-boot = "u-boot-custom"

UBOOT_MACHINE = "custom_board_defconfig"
UBOOT_ENTRYPOINT = "0x80008000"
UBOOT_LOADADDRESS = "0x80008000"
````

---

## 🖼️ İmaj Oluşturma ve Özelleştirme

### Temel İmaj Recipe'si

````bitbake
SUMMARY = "Custom Linux image"
LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += "ssh-server-dropbear debug-tweaks package-management"

IMAGE_INSTALL:append = " \
    htop \
    vim \
    wget \
    curl \
    git \
    python3 \
    custom-app \
"

# Root filesystem boyutu (MB)
IMAGE_ROOTFS_SIZE = "2048"

# Ek image formatları
IMAGE_FSTYPES += "tar.bz2 ext4 wic wic.bmap"
````

### İmaj Features Tablosu

| Feature | Açıklama |
|---------|----------|
| `debug-tweaks` | Root şifresiz giriş, development araçları |
| `ssh-server-dropbear` | SSH server (Dropbear) |
| `ssh-server-openssh` | SSH server (OpenSSH) |
| `package-management` | Runtime paket yöneticisi |
| `read-only-rootfs` | Salt okunur kök dosya sistemi |
| `x11-base` | X11 temel paketleri |
| `wayland` | Wayland display server |

### Distro Features

````bitbake
# local.conf içinde
DISTRO_FEATURES:append = " systemd vulkan wayland bluetooth wifi"
DISTRO_FEATURES:remove = "sysvinit"

# systemd kullanımı için
VIRTUAL-RUNTIME_init_manager = "systemd"
VIRTUAL-RUNTIME_initscripts = ""
````

---

## 🔧 SDK ve Cross-Compilation

### SDK Oluşturma

````bash
# Minimal toolchain
bitbake meta-toolchain

# Belirli bir imaj için SDK
bitbake -c populate_sdk core-image-minimal

# Extensible SDK (eSDK)
bitbake -c populate_sdk_ext core-image-minimal
````

### SDK Kurulum ve Kullanım

````bash
# SDK kurulumu
sudo ./poky-glibc-x86_64-core-image-minimal-cortexa9hf-neon-beaglebone-yocto-toolchain-4.0.sh

# SDK ortamını kaynak alma
source /opt/poky/4.0/environment-setup-cortexa9hf-neon-poky-linux-gnueabi

# Cross-compilation örneği
$CC hello.c -o hello
````

### devtool Kullanımı

````bash
# Yeni recipe oluşturma
devtool add myapp https://github.com/example/myapp.git

# Var olan recipe'yi geliştirme
devtool modify linux-yocto

# Değişiklikleri uygulama
devtool build myapp

# Recipe'yi layer'a taşıma
devtool finish myapp meta-custom
````

---

## 🐛 Hata Ayıklama ve Araçlar

### BitBake Komutları

````bash
# Recipe bilgilerini görme
bitbake -e recipe-name | grep VARIABLE

# Bağımlılık ağacını görme
bitbake -g recipe-name

# Task'ları listeleme
bitbake -c listtasks recipe-name

# Belirli task'ı çalıştırma
bitbake -c compile recipe-name

# Temizleme işlemleri
bitbake -c clean recipe-name
bitbake -c cleansstate recipe-name
bitbake -c cleanall recipe-name
````

### devshell Kullanımı

````bash
# Recipe'nin build ortamına girme
bitbake -c devshell recipe-name

# Kernel menuconfig
bitbake -c menuconfig virtual/kernel
````

### Quilt ile Patch Yönetimi

````bash
# Kaynak kodunu çıkarma
bitbake -c unpack recipe-name

# Çalışma dizinini bulma
bitbake -e recipe-name | grep ^S=

# Yeni patch başlatma
quilt new fix-bug.patch

# Dosya ekleme
quilt add src/main.c

# Değişiklikleri patch'e kaydetme
quilt refresh
````

### Log Dosyaları

````bash
# Build logları
build/tmp/work/MACHINE/RECIPE/VERSION/temp/

# Task logları
build/tmp/work/MACHINE/RECIPE/VERSION/temp/log.do_compile

# Run logları
build/tmp/work/MACHINE/RECIPE/VERSION/temp/run.do_compile
````

---

## 🚀 İleri Seviye Konular

### Multiconfig Kullanımı

````bash
# multiconfig.conf
[mc:target1]
MACHINE = "qemuarm"

[mc:target2]
MACHINE = "qemuarm64"

# Kullanım
bitbake mc:target1:core-image-minimal
````

### Custom Distribution

````bitbake
require conf/distro/poky.conf

DISTRO = "custom-distro"
DISTRO_NAME = "Custom Linux Distribution"
DISTRO_VERSION = "1.0"

MAINTAINER = "Your Name <your.email@example.com>"

# Custom features
DISTRO_FEATURES:append = " systemd vulkan"
DISTRO_FEATURES:remove = "sysvinit"

# Package preferences
PREFERRED_PROVIDER_virtual/kernel = "linux-custom"
````

### WIC Image Creator

````bash
part /boot --source bootimg-partition --ondisk mmcblk0 --fstype=vfat --label boot --active --align 4 --size 64
part / --source rootfs --ondisk mmcblk0 --fstype=ext4 --label root --align 4

bootloader --ptable msdos
````

### systemd Service Ekleme

````bitbake
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://custom-service.service"

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/custom-service.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} += "custom-service.service"
````

### Recipe Test Yazma

````bash
from oeqa.runtime.case import OERuntimeTestCase

class CustomTest(OERuntimeTestCase):
    def test_custom_app_exists(self):
        status, output = self.target.run('which custom-app')
        self.assertEqual(status, 0, 'custom-app not found')
````

---

## 📋 Faydalı Komutlar ve İpuçları

### Performance Optimizasyonu

````bash
# Paralel build ayarları
BB_NUMBER_THREADS = "16"
PARALLEL_MAKE = "-j 16"

# Shared state kullanımı
SSTATE_DIR = "/opt/yocto-sstate"
DL_DIR = "/opt/yocto-downloads"

# rm_work kullanımı (disk tasarrufu)
INHERIT += "rm_work"
RM_WORK_EXCLUDE += "linux-yocto"
````

### Image Yazma ve Test

````bash
# bmaptool ile hızlı yazma
sudo bmaptool copy image.wic /dev/sdX

# QEMU ile test
runqemu qemuarm64 core-image-minimal nographic

# Serial konsol bağlantısı
picocom -b 115200 /dev/ttyUSB0
````

### Recipe Arama ve Analiz

````bash
# Recipe arama
bitbake-layers show-recipes | grep pattern

# Layer dependencies
bitbake-layers show-layers

# Recipe append'lerini görme
bitbake-layers show-appends

# Recipe analizi
bitbake -s | grep package-name
````
