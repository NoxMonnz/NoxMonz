#!/bin/sh
# Main.sh - Script utama yang diunduh dan dieksekusi dari GitHub
# Disesuaikan untuk lingkungan Bourne Shell (sh) yang sangat minimalis di Brevent
# Semua script sementara disimpan di /data/local/tmp
# File konfigurasi update_status.conf disimpan di /storage/emulated/0/NoxXBPRO/settings/

# --- Penanda untuk Brevent ---
echo "--- Memulai NoxXBPRO Modul (Brevent Environment) ---"
# Anda bisa menambahkan lebih banyak detail di sini, seperti tanggal/waktu eksekusi
# echo "Waktu eksekusi: $(date)" # date mungkin ada, tapi bisa juga diganti dengan built-in jika perlu
# -----------------------------

# --- Konfigurasi Jalur ---
NOXXBPRO_BASE_DIR="/storage/emulated/0/NoxXBPRO"
SETTINGS_DIR="$NOXXBPRO_BASE_DIR/settings"
CONFIG_FILE="$SETTINGS_DIR/update_status.conf"
TEMP_DIR="/data/local/tmp"

# --- URL GitHub untuk file-file modul ---
# Ganti dengan detail repo GitHub Anda
GITHUB_REPO_RAW_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonnz/main"
GITHUB_VERSION_URL="$GITHUB_REPO_RAW_URL/version.txt"
INSTALL_SCRIPT_URL="$GITHUB_REPO_RAW_URL/install.sh"
UNINSTALL_SCRIPT_URL="$GITHUB_REPO_RAW_URL/uninstall.sh"

# --- Fungsi untuk mengunduh script dan memberinya izin eksekusi ---
# Ini masih sangat bergantung pada 'curl'. Jika 'curl' tidak ada di Brevent, ini akan gagal.
download_and_exec() {
    local url="$1"
    local temp_path="$2"
    # Gunakan sed untuk menghapus "local " yang tidak diperlukan di sh lama
    local args=""
    # Iterasi untuk mengumpulkan argumen. Bourne Shell tidak punya ${@:3}
    shift; shift; # Buang $1 (url) dan $2 (temp_path)
    for arg in "$@"; do
        args="$args \"$arg\"" # Kumpulkan argumen dengan tanda kutip
    done

    echo "Mengunduh: $url ke $temp_path"
    # Pastikan curl tersedia
    if ! command -v curl >/dev/null; then
        echo "ERROR: 'curl' tidak ditemukan. Gagal mengunduh file."
        return 1
    fi
    curl -sL "$url" -o "$temp_path"

    if [ ! -f "$temp_path" ]; then
        echo "ERROR: Gagal mengunduh script dari $url."
        return 1
    fi

    # Pastikan chmod tersedia
    if ! command -v chmod >/dev/null; then
        echo "ERROR: 'chmod' tidak ditemukan. Tidak bisa memberikan izin eksekusi."
        return 1
    fi
    chmod +x "$temp_path"

    # Jalankan script dengan argumen yang sudah dikumpulkan
    # Hati-hati dengan eval jika argumen mengandung spasi atau karakter khusus
    # Untuk skenario ini, args hanyalah 'install' atau 'uninstall' jadi aman
    sh "$temp_path" $args
    local exit_code=$?
    
    # Pastikan rm tersedia
    if ! command -v rm >/dev/null; then
        echo "PERINGATAN: 'rm' tidak ditemukan. File sementara tidak dihapus: $temp_path."
    else
        rm -f "$temp_path" # Hapus script sementara setelah selesai
    fi
    return $exit_code
}

# --- Fungsi untuk memeriksa dan menampilkan pembaruan ---
check_for_update() {
    # Pastikan mkdir tersedia
    if ! command -v mkdir >/dev/null; then
        echo "ERROR: 'mkdir' tidak ditemukan. Gagal membuat direktori $SETTINGS_DIR."
        return 1
    fi
    mkdir -p "$SETTINGS_DIR"

    # 1. Unduh versi terbaru dari GitHub
    # Ini masih bergantung pada curl.
    if ! command -v curl >/dev/null; then
        echo "ERROR: 'curl' tidak ditemukan. Gagal mendapatkan versi terbaru dari GitHub."
        return 1
    fi
    LATEST_GITHUB_VERSION=$(curl -sL "$GITHUB_VERSION_URL")

    if [ -z "$LATEST_GITHUB_VERSION" ]; then
        echo "PERINGATAN: Gagal mendapatkan versi terbaru dari GitHub. Cek koneksi internet atau URL."
        return 1 # Gagal cek update, anggap tidak ada update terdeteksi
    fi

    # 2. Baca versi lokal dari update_status.conf (gunakan manipulasi string murni sh)
    LOCAL_INSTALLED_VERSION="0.0.0" # Default jika file tidak ada atau kosong
    if [ -f "$CONFIG_FILE" ]; then
        # Baca baris pertama file. Ini asumsi file hanya berisi "VERSION=..."
        # Ini adalah solusi Bourne Shell murni tanpa grep/cut
        # Membaca seluruh file ke variabel, lalu mencari bagian "VERSION="
        # Ini tidak efisien untuk file besar, tapi update_status.conf sangat kecil.
        # Atau, bisa juga pakai read, tapi perlu loop atau trik lain.
        # Lebih baik baca per baris jika yakin ada, atau baca seluruhnya lalu cari.

        # Membaca seluruh file ke variabel (jika file kecil, ini OK)
        # Jika file terlalu besar, ini bisa jadi masalah.
        # Untuk update_status.conf yang cuma satu baris, ini cara termudah.
        LOCAL_VERSION_CONTENT=$(cat "$CONFIG_FILE" 2>/dev/null)
        
        # Ekstrak nilai VERSION menggunakan substitusi string Bourne Shell murni
        # Cari "VERSION=", lalu ambil sisanya, lalu hapus tanda kutip di awal/akhir.
        if [ -n "$LOCAL_VERSION_CONTENT" ]; then
            # Contoh: LOCAL_VERSION_CONTENT="VERSION=\"1.2.3\""
            # Hapus bagian "VERSION=\""
            TEMP_VERSION="${LOCAL_VERSION_CONTENT#VERSION=\"}"
            # Hapus tanda kutip penutup "
            LOCAL_INSTALLED_VERSION="${TEMP_VERSION%\"}"
        fi
    fi

    echo "--- Status Pembaruan ---
