---
# yaml-language-server: $schema=schemas/page.schema.json
Object type:
    - Page
Backlinks:
    - yocto.md
Creation date: "2025-07-18T07:35:19Z"
Created by:
    - elbis
id: bafyreielujgdzduskw23ohcyiqfqx6escqbfcsr5ft3of7pdjuxnrnjwim
---
# ders 6 bsp layers   
`meta-ti` → ti karta özel yazılım donanıkmların desteklediği ayarların yapıldığı yerdir   
- donanıma özel   
- farklı kernel ve boot-loader   
- module and drivers   
- önceden derli binary ve firmwareler   
   
   
### Bazı makineye özel ayarlar   
- **TARGET\_ARCH**: amd64, arm64, x86   
- **PREFERRED\_PROVIDER\_virtual**/kernel: The default kernel.   
- **MACHINE\_FEATURES**: List of hardware features provided by the machine, e.g. `usbgadget`  `usbhost`  `screen`  `wifi`    
- **SERIAL\_CONSOLES**: Speed and device for the serial consoles to attach. Used to configure getty, e.g. 115200;ttyS0   
- **KERNEL\_IMAGETYPE**: The type of kernel image to build, e.g. zImage   
   
   
### derinlemesine parametre aramak için   
```
grep -rn parametre
```
### devshel ile linux defconfig kaydetme   
```
bitbake -c devshell linux-bb.org # devshell'e girme

```
   
### toolchain kurulumu   
```
sudo apt-get update
sudo apt-get install g++-arm-linux-gnueabi

bitbake meta-toolchain

```
### menuconfig   
```
bitbake -c menuconfig virtual/kernel # menuconfig açımı
bitbake -c defconfig virtual/kernel # configi defconfig olarak kaydetme
# arada olan xxx.cfg ile aradaki farklar alınabilir
```
   
## `beagley-ai.conf`  - Ana Makine Yapılandırması   
- **Amaç**: BeagleY AI kartının temel yapılandırma dosyası   
- **İşlevi**:   
    - J722S işlemci mimarisini kullanır   
    - BeagleBoard.org 6.1 kernel sürümünü tercih eder   
    - A53 çekirdeği için U-Boot yapılandırması   
    - Device tree dosyalarını belirler   
    - Büyük ekran GUI sınıfını aktifleştirir   
   
## `j722s.inc`  - İşlemci Ailesi Yapılandırması   
- **Amaç**: TI J722S işlemci ailesine özel ayarlar   
- **Özellikler**:   
    - K3 mimarisi ve R5 multi-core desteği   
    - GPU ve ekran desteği   
    - PowerVR grafik sürücüleri   
    - HS-FS ve HS-SE güvenlik modları   
    - CNM Wave firmware desteği   
   
## `k3.inc`  - TI K3 Mimari Yapılandırması   
- **Amaç**: TI K3 işlemci mimarisi için temel ayarlar   
- **İçerik**:   
    - ARM64 mimarisi (Cortex-A53/A72)   
    - FIT Image kernel formatı   
    - U-Boot imzalama ve güvenlik   
    - EFI boot desteği   
    - Serial konsol ayarları   
   
## `ti-bsp.inc` - BSP Sürüm Yönetimi   
- **Amaç**: Farklı kernel ve bootloader sürümlerini yönetir   
- **Seçenekler**:   
    - `mainline`: En güncel upstream kernel   
    - `ti-6\_6`: TI staging kernel 6.6   
    - `ti-6\_1`: TI staging kernel 6.1   
    - GPU sürücü versiyonları ve tercihleri   
   
### derlemede hatalı olanı temizleme   
```
bitbake -c cleansstate gcc-cross-aarch64
```
   
# olası bir hata durumunda   
```
rm -rf build/tmp/*
rm -rf build/sstatae-cahe/*

```
