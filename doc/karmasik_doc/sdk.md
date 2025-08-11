---
# yaml-language-server: $schema=schemas/page.schema.json
Object type:
    - Page
Backlinks:
    - yocto.md
Creation date: "2025-07-24T12:13:48Z"
Created by:
    - elbis
id: bafyreidajwriyc6iht35zexpvarlgcvjqft24ch43jjas6fhezebssajp4
---
# sdk   
### toolchain oluşturma   
```
 bitbake meta-toolchain

```
```
 bitbake -c populate_sdk core-image-minimal
```
   
### oluşan toolchini kullanma   
```
cd /opt/poky/5.0
source ./environment-setup-cortexa8hf-neon-poky-linux-gnueabi
```
   
# devtool   
build/workspace içinde bizimi için bir recpie deneyebileceğimz bir ortam oluşturur   
```
devtool add <recipe> <fetchuri>
```
### istresek oluşturduğumuz kısmı ana konumumuza atabiliriz   
```
devtool finish recipe layer
```
   
> farklı bir bilgisayarda kullancağımız sdk için tüm değişkenler atanacak   

   
   
   
