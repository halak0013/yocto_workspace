---
# yaml-language-server: $schema=schemas/page.schema.json
Object type:
    - Page
Backlinks:
    - yocto-doc.md
Creation date: "2025-07-22T13:12:57Z"
Created by:
    - elbis
id: bafyreiekfrqai3yanfjnf63eznb5pb7432nglx2vck5vpxnadqhxbjwtfy
---
# başlangıç   
### derlenmiş dosyaları kullanmak için   
```
BB_HASHSERVE_UPSTREAM = "wss://hashserv.yoctoproject.org/ws"
SSTATE_MIRRORS ?= "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH"
BB_HASHSERVE = "auto"
BB_SIGNATURE_HANDLER = "OEEquivHash"
```
### dermeme gidebildiği yere kadar gitsin   
```
BB_HASHSERVE_UPSTREAM = "wss://hashserv.yoctoproject.org/ws"
SSTATE_MIRRORS ?= "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH"
BB_HASHSERVE = "auto"
BB_SIGNATURE_HANDLER = "OEEquivHash"
```
   
### site.conf auto.conf   
```
PACKAGE_CLASSES = "package_ipk"
DL_DIR = "/mnt/shared/downloads"
SSTATE_DIR = "/mnt/shared/sstate-cache"
```
site.conf -> farklı makinal için ortak ayarları saklamak için   
auto.conf -> otomatik olarak oluşur. değiştirme   
   
### bsp-layer   
donanımla alakalı kısmıların olduğu katman   
`recipes-bsp`, `recipes-core`, `recipes-graphics`, `recipes-kernel`   
   
```
PACKAGE_CLASSES = "package_ipk"
DL_DIR = "/mnt/shared/downloads"
SSTATE_DIR = "/mnt/shared/sstate-cache"
```
   
### image içine hangi dildeki paketlerin ekleneceği   
IMAGE\_LINGUAS = "en-us tr"   
   
Elbette! Aşağıda verdiğin Yocto değişkenlerini, görevleri ve nasıl kullanıldıklarını **ayrıntılı, açık ve örneklerle** anlatıyorum. Bu değişkenlerin çoğu **bir imajın (image)** içine hangi paketlerin girip girmeyeceğini kontrol eder. Yocto’nun **image oluşturma süreci** açısından kritik rol oynarlar.   
 --- 
Genellikle `.bb` dosyasında veya `local.conf`, `image.bb` tariflerinde.   
### 🧪 Örnek:   
## ❌ 2. PACKAGE\_EXCLUDE   
> Tanım: Belirtilen paketlerin imaja dahil edilmesini yasaklar.   

### 🧪 Örnek:   
- Bu satır sayesinde `busybox` paketi sisteme **yüklenmeyecek**.   
- Eğer başka bir paket bu paketi bağımlılık olarak istiyorsa, derleme hata verebilir.   
   
🔎 D**ikkat: **Eğer eksik edilen paket z**orunlu bağımlılık **ise, bu hatalara neden olabilir.   
 --- 
## 🌟 3. IMAGE\_FEATURES   
> Tanım: Imaj içerisine dahil edilecek ön tanımlı özellikleri (paket grupları) belirtir.   

### 📚 Yaygın Özellikler:   
- `ssh-server-dropbear`   
- `debug-tweaks`   
- `package-management`   
- `tools-profile`   
- `read-only-rootfs`   
   
### 🧪 Örnek:   
- Bu sayede sistem SSH ile başlatılır ve root şifresi gerekmez.   
   
📌 İ**pucu: **I`MAGE\_FEATURES `aslında I`MAGE\_INSTALL `içine otomatik olarak bazı paketleri ekler.   
 --- 
## 📦 4. PACKAGE\_CLASSES   
> Tanım: Hangi paket yöneticisinin (RPM, DEB, IPK) kullanılacağını belirler.   

### 🧪 Örnek:   
```
PACKAGE_CLASSES = "package_ipk"


```
- `package\_ipk`: OpenEmbedded’in varsayılanı   
- `package\_deb`: Debian sistemleri için   
- `package\_rpm`: Red Hat/Fedora tarzı sistemler için   
   
🔎 Bu değişken:   
- Paketlerin nasıl oluşturulacağını belirler.   
- Paket feed dizinleri ( `deploy/ipk`, `deploy/deb`) bu tercihe göre oluşturulur.   
 --- 
   
## 🌍 5. IMAGE\_LINGUAS   
> Tanım: Hangi dil destek paketlerinin imaj içine dahil edileceğini belirler.   

### 🧪 Örnek:   
```
IMAGE_LINGUAS = "en-us tr"


```
- Bu durumda İngilizce (ABD) ve Türkçe dil destek dosyaları dahil edilir.   
- Eğer boş bırakılırsa, tüm diller **dahil edilmez** (daha küçük imaj boyutu).   
 --- 
   
## 📋 6. PACKAGE\_INSTALL   
> Tanım: İmaj oluşturulurken paket yöneticisine gerçek gönderilen son kurulum listesi.   

### 🚨 Not:   
- Bu değişkeni genellikle **elle değiştirmezsin**.   
- BitBake, `IMAGE\_INSTALL`, `IMAGE\_FEATURES`, `DISTRO\_FEATURES`, bağımlılıklar vb. üzerinden bu listeyi **otomatik oluşturur**.   
   
🔎 Ancak bir i`mage.bbclass `veya özel bir m`eta `katman geliştiriyorsan, bu değişkeni elle ayarlaman gerekebilir.   
 --- 
## 🎯 Özet Tablo   
|           Değişken |                                                            Görevi |                                  Not |
|:-------------------|:------------------------------------------------------------------|:-------------------------------------|
|   `IMAGE\_INSTALL` |                 Dahil edilmesini istediğin **paketlerin listesi** |              Elle tanımlanır ( `+=`) |
| `PACKAGE\_EXCLUDE` |                        Dahil edilmesini **engellediğin** paketler |             Derleme hatası riski var |
|  `IMAGE\_FEATURES` |                    Dahil edilecek **ön tanımlı özellik grupları** | `debug-tweaks`, `ssh-server-\*` gibi |
| `PACKAGE\_CLASSES` |                Kullanılacak **paketleme sistemi** (ipk, deb, rpm) |               `package\_ipk` default |
|   `IMAGE\_LINGUAS` |                           Dahil edilecek **dil destek paketleri** |              `en-us`, `tr`, `de` vb. |
| `PACKAGE\_INSTALL` |     Derleme sırasında **paket yöneticisine gönderilen son liste** |              Genelde otomatik oluşur |

 --- 
## ✅ Kullanım Senaryosu Örneği   
```
IMAGE_FEATURES += "ssh-server-dropbear debug-tweaks"
IMAGE_INSTALL += "htop curl"
PACKAGE_EXCLUDE += "connman"
IMAGE_LINGUAS = "en-us tr"
PACKAGE_CLASSES = "package_ipk"


```
Bu yapılandırma şu anlama gelir:   
- SSH desteği + root şifresiz oturum var.   
- `htop` ve `curl` kurulu gelir.   
- `connman` kesinlikle kurulmaz.   
- Sadece İngilizce ve Türkçe dil dosyaları dahil edilir.   
- Paketleme yöntemi `ipk`’dir.   
 --- 
   
İstersen bu değişkenleri içeren örnek bir `core-image-custom.bb` tarif dosyası yazabiliriz. Yardımcı olayım mı?   
   
   
IMAGE\_FEATURES += "ssh-server-dropbear debug-tweaks"
IMAGE\_INSTALL += "htop curl"
PACKAGE\_EXCLUDE += "connman"
IMAGE\_LINGUAS = "en-us tr"
PACKAGE\_CLASSES = "package\_ipk"   
   
   
hash equivalence -> paket kodunda boşluk gibi çıktıyı değiştirmeyecek durumlar olmasına karşı hash değişse de yenider derlmeyi engellleyen sistem   
    
Elbette! Aşağıda Yocto projesinde yaygın olarak kullanılan değişkenleri ve görevleri (tasks) **kısa ve öz açıklamalarıyla** tablo halinde derledim. Bu tablo, recipe (tarif) yazarken ya da okurken çok işine yarayacaktır:   
 --- 
### 🔧 Genel Recipe Değişkenleri   
|                 Değişken |                                                                                  Açıklama |
|:-------------------------|:------------------------------------------------------------------------------------------|
|               `HOMEPAGE` |                                       Paketin ana sayfa URL’si (belge veya proje sitesi). |
|             `BUGTRACKER` |                                        Hata takip sisteminin URL’si (Jira, Bugzilla vb.). |
|                `SECTION` |                                Paketin kategorisini belirtir (örneğin: libs, net, utils). |
|                `LICENSE` |                                          Yazılımın lisans bilgisi ( `GPLv2`, `MIT`, vb.). |
|     `LIC\_FILES\_CHKSUM` |            Lisans dosyasının kontrol toplamı (SHA256). Lisansın doğruluğu kontrol edilir. |
|                `DEPENDS` |                       Derleme zamanında gereken diğer tarifler (build-time dependencies). |
|               `PROVIDES` |           Bu tarifin sağladığı sanal paket(ler). Alternatif sağlayıcılar için kullanılır. |
|                     `PV` |       Paket sürümü (Package Version). Genelde otomatik ayarlanır ama elle de verilebilir. |
|               `SRC\_URI` |                                   Kaynak dosyalarının URI'leri (HTTP, git, file://, vb.). |
|                 `SRCREV` |                               Git gibi VCS sistemlerinden çekilecek commit hash veya tag. |
|                      `S` |         Kaynak dizininin yolu (untar + patch sonrası). Genelde `${WORKDIR}/<dizin>` olur. |
|                `inherit` |                Belirtilen class’ları dahil eder (örneğin: `autotools`, `cmake`, `image`). |
|          `PACKAGECONFIG` |                                    Özellikleri açıp kapamak için yapılandırma bayrakları. |
|          `EXTRA\_OECONF` |                                        `./configure` sırasında ek argümanlar vermek için. |
| `EXTRA\_QMAKEVARS\_POST` |                                   qmake projelerinde ek build-time değişkenleri tanımlar. |

 --- 
### 📦 Paketleme ile İlgili Değişkenler   
|        Değişken |                                                                        Açıklama |
|:----------------|:--------------------------------------------------------------------------------|
| `PACKAGE\_ARCH` |                         Paketin hedef mimarisi ( `all`, `arm`, `x86\_64`, vs.). |
|      `PACKAGES` |                                       Oluşturulacak tüm alt paketlerin listesi. |
|         `FILES` |                                    Her bir pakete dahil edilecek dosya yolları. |
|      `RDEPENDS` |                           Çalışma zamanı bağımlılıkları (runtime dependencies). |
|   `RRECOMMENDS` |       Tavsiye edilen bağımlılıklar. Otomatik yüklenebilir ama zorunlu değildir. |
|     `RSUGGESTS` |                            Opsiyonel bağımlılıklar, kurulum sırasında önerilir. |
|     `RPROVIDES` |                                          Bu paketin sağladığı sanal paket(ler). |
|    `RCONFLICTS` |                                    Birlikte kurulmaması gereken diğer paketler. |
| `BBCLASSEXTEND` |           Tarifin türevlerini otomatik oluşturur ( `native`, `nativesdk`, vs.). |

 --- 
### 🛠️ Yocto Görevleri (BitBake Tasks)   
|                          Görev |                                                                 Açıklama |
|:-------------------------------|:-------------------------------------------------------------------------|
|                    `do\_fetch` |                                                  Kaynak kodları indirir. |
|                   `do\_unpack` |                                       Arşivleri açar (untar, unzip vb.). |
|                    `do\_patch` |                                                Gerekli yamaları uygular. |
| `do\_prepare\_recipe\_sysroot` |                             Tarifin derleme ortamını hazırlar (sysroot). |
|                `do\_configure` |         Otomatik yapılandırma çalıştırılır ( `configure`, `cmake`, vb.). |
|                  `do\_compile` |                                                  Kaynak kodlar derlenir. |
|                  `do\_install` |                              Dosyalar hedef dizinlere ( `${D}`) kurulur. |
|        `do\_populate\_sysroot` |            Kurulmuş dosyalar sysroot'a kopyalanır (başka tarifler için). |
|                  `do\_package` |                              Derlenen çıktı dosyaları paketlere ayrılır. |

 --- 
> 🔁 Not: Bazı değişkenlerde sıralama önemlidir. Örneğin PACKAGE_ARCH, bazı inherit işlemlerinden önce ayarlanmalıdır.   

 --- 
İstersen bu değişkenlerin nasıl birlikte çalıştığını örnek bir `hello.bb` tarif dosyası ile de gösterebilirim. Yardımcı olmamı ister misin?   
   
   
   
`core-image-weston`: A very basic Wayland image with a terminal.
This image provides the Wayland protocol libraries and the reference
Weston compositor. For more information, see the
“ [Using Wayland and Weston](https://docs.yoctoproject.org/5.0.11/dev-manual/wayland.html#using-wayland-and-weston)”
section in the Yocto Project Development Tasks Manual.   
   
   
Distro featureye nasılsın ve systemd ekle   
   
Ena distroya vulkan wayland ekle   
   
İmage featureye allow-root-login: ekle empty-root-password:serial-autologin-root:    
   
hwcodecs: Installs hardware acceleration codecs.    
   
   
