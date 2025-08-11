---
# yaml-language-server: $schema=schemas/page.schema.json
Object type:
    - Page
Backlinks:
    - yocto.md
Creation date: "2025-08-05T16:45:57Z"
Created by:
    - elbis
Links:
    - 11-features-the-yocto-project-r-5-0-11-documen.md
id: bafyreibq7jwf6hkiekkf5ezevigqb5q74emn54ccyquxzrfxucvhbgmsky
---
# doc 2   
## Machine Features   
## Distro Features   
## Image Features   
[11 Features — The Yocto Project ® 5.0.11 documentation](https://docs.yoctoproject.org/5.0.11/ref-manual/features.html#ref-features-image)    
hazır recepie oluşturma   
```
mkdir -p meta-bismih/recipes-extended/htop

recipetool create -o meta-bismih/recipes-extended/htop/htop.bb "git://github.com/htop-dev/htop.git;protocol=https;branch=main

```
   
Bunlara tekrar bi bak   
{S} {D} {WORKDIR}   
   
### Basitçe img yazma   
```
sudo bmaptool copy build-directory/tmp/deploy/images/machine/image.wic /dev/sdX
```
