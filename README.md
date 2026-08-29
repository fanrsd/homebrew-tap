# homebrew-tap

Tap Homebrew untuk [Zerofuss](https://zerofuss.margingroup.id/) - live view goggles DJI di
jendela desktop lewat kabel USB.

```sh
brew install --cask fanrsd/tap/zerofuss
xattr -dr com.apple.quarantine /Applications/Zerofuss.app
```

Baris `xattr` itu diperlukan karena build-nya belum ditandatangani Apple:
tanpa itu Gatekeeper menolak aplikasinya dengan "aplikasi rusak" - yang kurang
tanda tangannya, bukan berkasnya. Flag `--no-quarantine` yang dulu mengurusnya
sudah dibuang Homebrew di 4.7, jadi memakainya hanya menghasilkan
`invalid option`. Cask ini mencetak perintah penggantinya sesudah memasang.

Cask di sini DIBANGKITKAN: ia disalin dari repo sumber Zerofuss oleh
`rilis-mac.sh` setiap rilis, lengkap dengan versi dan sha256 yang sudah terisi.
Suntingan tangan di sini akan tertimpa.
