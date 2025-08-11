# Bealey-ai kartı için yocto alanı
Burada bir çok işleminizi sistemden bağımsız bir şekilde yapabilirsiniz.

# Kendi tuttuğum karmaşık doc
[Karmaşık belgelendirme](doc/karmasik_doc/yocto.md)

# Düzeltilmiş hali
[Düzenli hali](doc/duzenli_hali.md)

# Kurulum

taskfile kurulumu
```bash
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin
```

# Kullanım
```bash
task yh
```

Distrobox vs kurulumdan sonra giriş yaptığınızda aşağıdaki gibi bir ekran ile karşılaşacaksınız.

```bash
__   __         _          _   _                  
\ \ / /__   ___| |_ ___   | | | | __ _ _ __   ___ 
 \ V / _ \ / __| __/ _ \  | |_| |/ _` | '_ \ / _ \
  | | (_) | (__| || (_) | |  _  | (_| | | | |  __/
  |_|\___/ \___|\__\___/  |_| |_|\__,_|_| |_|\___|
🌪 distrobox:~>
```


# Gerekli depolara çekme
```bash
task fetch
```

# Tüm alanı silme
```bash
task destroy
```

# İlk kullanım

```bash
task yh # konteyneri başlatır
task fetch # gerekli depoları çeker
cd ~/yocto-labs # yocto dizinine geçer
source poky/oe-init-build-env # yocto ortamını başlatır

# $BUILDDIR/conf/bblayers.conf içinden 
# data/bblayers.conf göre konumlar düzenlenmeli

# $BUILDDIR/conf/local.conf içinden MACHINE aşağıdaki gibi düzenlenmeli
# MACHINE ??= "beagley-ai"

# ! çok uzun sürebilir, sabırlı olun :)
bitbake core-image-minimal # ilk imajı oluşturur
```