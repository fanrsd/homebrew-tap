# Cask Zerofuss untuk TAP SENDIRI, bukan homebrew-cask resmi.
#
#   brew install --cask fanrsd/tap/zerofuss
#
# Berkas ini SUMBERNYA. Yang dipasang Homebrew adalah salinannya di
# github.com/fanrsd/homebrew-tap, dan `rilis-mac.sh` yang menyalinnya ke sana
# setiap rilis - lengkap dengan versi dan sha256 yang sudah terisi. Jangan
# mengedit salinan di tap: ia akan tertimpa.
#
# Kenapa tap sendiri, bukan homebrew-cask resmi: yang resmi menuntut aplikasi
# yang ditandatangani DAN dinotarisasi Apple, karena cask tanpa notarisasi akan
# dimatikan Gatekeeper di mesin pemakai. Selama Zerofuss belum punya Developer
# ID, tap sendiri adalah satu-satunya jalur yang jujur.
#
# SESUDAH memasang, aplikasinya masih terkarantina Gatekeeper karena build ini
# belum ditandatangani Apple. Satu perintah, sekali per salinan:
#
#   xattr -dr com.apple.quarantine /Applications/Zerofuss.app
#
# Flag `--no-quarantine` yang dulu mengurus ini SUDAH TIDAK ADA: Homebrew
# membuangnya di 4.7 (Homebrew/brew#20755) dan 5.0 mendeprekasi seluruh
# mekanisme bypass-nya. Memakainya sekarang hanya menghasilkan
# "invalid option: --no-quarantine". Blok `caveats` di bawah mencetak perintah
# penggantinya begitu pemasangan selesai, jadi pemakai tidak perlu mencarinya.
#
# Arah akhirnya jelas dan bukan pilihan kita: Homebrew mewajibkan seluruh cask
# lolos Gatekeeper per September 2026. Begitu ada Developer ID Apple dan
# notarisasi, blok caveats itu dihapus dan pemasangannya jadi satu baris tanpa
# ekor.
#
# Dua berkas, bukan satu universal: unduhan per-arsitektur separuh ukuran, dan
# blok on_arm/on_intel di bawah ini justru dibuat untuk memilihnya sendiri.
#
# `sha256 :no_check` di bawah hanya untuk keadaan belum-ada-rilis.
# `rilis-mac.sh` menggantinya dengan hash sungguhan; kalau kamu melihat
# :no_check di tap, berarti skrip itu belum pernah jalan.

cask "zerofuss" do
  version "0.1.0"

  on_arm do
    sha256 "722441df4761db7520efe6652453b22d59e586a8cb066b96a253d1c1bcf7a597"
    url "https://github.com/fanrsd/zerofuss-releases/releases/download/v#{version}/Zerofuss_#{version}_aarch64.dmg",
        verified: "github.com/fanrsd/zerofuss-releases/"
  end

  on_intel do
    sha256 "4b27acc24acaa7e8556e7f98a9aa4bece3fd96c6ea87ae4dc436108ae46a313d"
    url "https://github.com/fanrsd/zerofuss-releases/releases/download/v#{version}/Zerofuss_#{version}_x64.dmg",
        verified: "github.com/fanrsd/zerofuss-releases/"
  end

  name "Zerofuss"
  desc "Live view DJI Goggles di jendela desktop lewat kabel USB-C"
  homepage "https://zerofuss.margingroup.id/"

  # Big Sur adalah macOS pertama untuk Apple Silicon; di bawah itu build arm64
  # tidak ada gunanya dan WKWebView-nya sudah terlalu tua.
  depends_on macos: ">= :big_sur"

  app "Zerofuss.app"

  # Identifier bundle-nya id.zerofuss.desktop (app/src-tauri/tauri.conf.json),
  # jadi ketiga jalur ini yang ditinggalkan aplikasi. Rekaman di ~/Movies
  # SENGAJA tidak ikut di-zap: itu berkas pemakai, bukan berkas aplikasi.
  zap trash: [
    "~/Library/Application Support/id.zerofuss.desktop",
    "~/Library/Caches/id.zerofuss.desktop",
    "~/Library/Saved Application State/id.zerofuss.desktop.savedState",
  ]

  # Dicetak brew sendiri sesudah pemasangan. Sengaja TIDAK dikerjakan lewat
  # `postflight`: mencabut Gatekeeper diam-diam untuk pemakai adalah hal yang
  # tidak boleh dilakukan tanpa dia tahu - dan itu justru yang membuat Homebrew
  # membuang `--no-quarantine`. Perintahnya ditunjukkan, pemakainya yang
  # memutuskan.
  caveats <<~EOS
    Build ini belum ditandatangani Apple, jadi Gatekeeper masih menahannya.
    Sekali per salinan aplikasi:

      xattr -dr com.apple.quarantine /Applications/Zerofuss.app

    Yang kurang tanda tangannya, bukan berkasnya. Flag --no-quarantine sudah
    dibuang Homebrew 4.7, jadi jalur inilah penggantinya.
  EOS
end
