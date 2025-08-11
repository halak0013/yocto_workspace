---
# yaml-language-server: $schema=schemas/page.schema.json
Object type:
    - Page
Backlinks:
    - yocto.md
Creation date: "2025-08-07T09:39:14Z"
Created by:
    - elbis
id: bafyreicloggft56a6lrk6hecy663mtbls5pzehh6sidbed5wfth3glve3a
---
# quilt   
Bir dosya üzerinde hızlıca değişiklik yapmak için quilt kullanılabilir.   
### Paketi çıkarma için   
```
bitbake ninvaders -c unpack
```
### Kaynak kodunu bulmak için   
```
bitbake -e ninvaders | grep ^S=

# S="/home/bismih/projelerimiz3/yocto_workspace/.distrobox/yocto-labs/build/tmp/work/aarch64-poky-linux/ninvaders/0.1.1/ninvaders-0.1.1"
# cd ile çalışma alanına gidilir
```
```
# yeni bir patch başlatma
quilt new ninvaders-print-change.patch

# patch için takip edilecekler
quilt add player.c
# değişiklikler yapılır

# test için derleme
bitbake -c compile -f ninvaders

# patch güncellemek için
quilt refresh

```
    
