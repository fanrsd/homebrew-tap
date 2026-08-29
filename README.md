# homebrew-tap

Tap Homebrew untuk [Zerofuss](https://zerofuss.app/) - live view goggles DJI di
jendela desktop lewat kabel USB.

```sh
brew install --cask --no-quarantine fanrsd/tap/zerofuss
```

`--no-quarantine` diperlukan karena build-nya belum ditandatangani Apple.
Tanpa flag itu aplikasinya terpasang tapi Gatekeeper menolaknya dengan
"aplikasi rusak" - yang kurang tanda tangannya, bukan berkasnya.

Cask di sini DIBANGKITKAN: ia disalin dari repo sumber Zerofuss oleh
`rilis-mac.sh` setiap rilis, lengkap dengan versi dan sha256 yang sudah terisi.
Suntingan tangan di sini akan tertimpa.
