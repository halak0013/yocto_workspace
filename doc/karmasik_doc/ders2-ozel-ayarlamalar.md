---
# yaml-language-server: $schema=schemas/page.schema.json
Object type:
    - Page
Backlinks:
    - yocto.md
Creation date: "2025-07-12T08:54:56Z"
Created by:
    - elbis
id: bafyreigdav3xbqxi2r5kuzomc3d3l3w7fpnrucbjj3dfq6bpbb2zsx3dtq
---
# ders2 özel ayarlamalar   
# Değişken işlemleri   
### atama   
```
COLOUR ?= "unknown" #eğer
```
=   
refransla değişken  ataması   
```
COLOUR = "blue"
SKY = "the sky is ${COLOUR}"
COLOUR = "grey"
PHRASE = "Look, ${SKY}"

# PHRASE = "Look, the sky is grey"
```
:=   
direk değişken ataması   
```
COLOUR = "blue"
SKY := "the sky is ${COLOUR}"
COLOUR = "grey"
PHRASE = "Look, ${SKY}"

# PHRASE = "Look, the sky is blue"
```
![image](files/image_l.png)    
### Değişken güncelleme   
```
+= append (with space)
=+ prepend (with space)
.= append (without space)
=. prepend (without space)
```
### koşullu durum   
değişkende belli bir parça varsa veya yoksa işlem yapılması   
override içine bakar   
```
OVERRIDES="arm:armv7a:ti-soc:ti33x:beaglebone:poky"
KERNEL_DEVICETREE:beaglebone = "am335x-bone.dtb" # This is applied
KERNEL_DEVICETREE:dra7xx-evm = "dra7-evm.dtb"
# This is ignored
```
### sanal atama   
```
PREFERRED_PROVIDER_virtual/kernel ?= "linux-ti-staging"
PREFERRED_PROVIDER_virtual/libgl = "mesa"
```
   
![image](files/image_q.png)    
![image](files/image.png)    
