---
# yaml-language-server: $schema=schemas/page.schema.json
Object type:
    - Page
Backlinks:
    - yocto.md
Creation date: "2025-07-04T11:53:47Z"
Created by:
    - elbis
id: bafyreihcelqaph4mh2tl7455bs5jghhovmxm7eetjtcmzysea2yfnhe24y
---
# lab1 kurulum   
```
distrobox-create --image ubuntu:22.04  --name yokto_proj --home /home/bismih/projelerimiz3/yocto_proje/
```
```
sudo apt update
sudo apt dist-upgrade
```
```
sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential \
chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils \
iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file \
locales libacl1
```
```
kernel.apparmor_restrict_unprivileged_userns = 0
sudo nano /etc/sysctl.d/99-unprivileged-userns.conf
sudo sysctl --system
```
```
  /home/bismih/projelerimiz3/yocto_proje/yocto-labs/poky/meta \
  /home/bismih/projelerimiz3/yocto_proje/yocto-labs/poky/meta-poky \
  /home/bismih/projelerimiz3/yocto_proje/yocto-labs/poky/meta-yocto-bsp \
  /home/bismih/projelerimiz3/yocto_proje/yocto-labs/meta-arm/meta-arm/ \
  /home/bismih/projelerimiz3/yocto_proje/yocto-labs/meta-arm/meta-arm-toolchain/ \
  /home/bismih/projelerimiz3/yocto_proje/yocto-labs/meta-ti/meta-ti-bsp/ \

```
   
   
   
# diske dosya ortamını yazmak için   
```
# 1. Diskin bağlantısını kesin (eğer bağlıysa)
sudo umount /dev/sda1  # Eğer bağlıysa

# 2. Diskin formatlanması
sudo mkfs.ext4 /dev/sda  # sda diskini ext4 dosya sistemi ile formatla

# 3. Montaj noktası oluştur
sudo mkdir -p /mnt/sda

# 4. Diskin montajını yap
sudo mount /dev/sda /mnt/sda

# 5. Çıkarılan dosyaları diske kopyala
sudo cp -r /tmp/rootfs/* /mnt/sda/

# 6. Diskin montajını kaldır
sudo umount /mnt/sda

```
`bsp`  → borad spesific package → uboot kernela kadar bi çok paket   
`bitbake` → make tarzı derleme aracı   
   
   
