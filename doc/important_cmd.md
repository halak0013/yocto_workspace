Yocto ile geliştirme yaparken sık kullanılan ve önemli komutların açıklamalarıyla birlikte bir listesini aşağıda bulabilirsin. Bunu `important_cmd.md` dosyana ekleyebilir veya yeni bir bölüm olarak kullanabilirsin:

---

## Yocto Geliştirme için Önemli Komutlar

### 1. Bitbake Ortamını Yükleme
```bash
source $HOME/yocto-labs/poky/oe-init-build-env
```
> Bitbake ve Yocto ortam değişkenlerini yükler. Her yeni terminal oturumunda çalıştırılmalıdır.

### 2. Temel Bitbake Komutları

- Tüm imajı derlemek:
  ```bash
  bitbake core-image-minimal
  ```
  > Seçilen imajı derler (ör. core-image-minimal, core-image-sato).

- Belirli bir paketi derlemek:
  ```bash
  bitbake <paket-adı>
  ```
  > Sadece ilgili paketi derler.

- Temiz derleme yapmak:
  ```bash
  bitbake -c clean <paket-adı>
  ```
  > Paketle ilgili tüm derleme çıktısını temizler.

- Derleme önbelleğini temizlemek:
  ```bash
  bitbake -c cleansstate <paket-adı>
  ```
  > Paketle ilgili tüm önbellek ve derleme dosyalarını temizler.

### 3. Katman (Layer) Yönetimi
> Katmanları oluştururken yocto-labs dizininde `meta-<layer-adı>` şeklinde isimlendirme yapabilirsin.
- Katmanları listelemek:
  ```bash
  bitbake-layers show-layers
  ```
- Katman oluşturma:
    ```bash
    bitbake-layers create-layer meta-<layer-adı>
    ```
- Katman eklemek:
  ```bash
  bitbake-layers add-layer meta-<layer-adı>
  ```
- Katman çıkarmak:
  ```bash
  bitbake-layers remove-layer meta-<layer-adı>
  ```

### 4. Bilgi ve Hata Ayıklama

- Paket hakkında bilgi almak:
  ```bash
  bitbake -e <paket-adı> | less
  ```
- Bağımlılık ağacını görmek:
  ```bash
  bitbake -g <paket-adı>
  ```
  > `pn-depends.dot` ve `package-depends.dot` dosyalarını oluşturur.

- Derleme sırasında hata ayıklama:
  ```bash
  bitbake -v <paket-adı>
  ```
  > Daha ayrıntılı çıktı verir.

### 5. Çıktı Dizinleri

- Derlenen imajlar: `build/tmp/deploy/images/<makine-adı>/`
- Paketler: `build/tmp/deploy/ipk/`, `rpm/`, veya `deb/`

---