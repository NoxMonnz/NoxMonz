#!/bin/bash

# --- Konfigurasi ---
GITHUB_STATUS_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/control.txt"
LOCAL_STATUS_FILE="/data/local/tmp/control.txt" # Lokasi lokal untuk menyimpan control.txt
GITHUB_URL_INSTALL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/install.sh"
DIR_INSTALL="/data/local/tmp/install.sh"

THIS_VERSION="V1.4.5"
NEW_VERSION="V1.6.6"

# --- Unduh file control.txt dari GitHub ---
# Menggunakan curl untuk mengunduh file
if ! curl -sL "$GITHUB_STATUS_URL" -o "$LOCAL_STATUS_FILE"; then
    echo "Gagal mengunduh file status pembaruan. Pastikan URL benar dan ada koneksi internet."
    exit 1
fi

# --- Pastikan file status lokal berhasil diunduh ---
if [ ! -f "$LOCAL_STATUS_FILE" ]; then
    echo "Kesalahan: File status pembaruan lokal tidak ditemukan setelah diunduh."
    exit 1 # Keluar dengan kode error
fi

# --- Baca status dari file lokal ---
STATUS=$(cat "$LOCAL_STATUS_FILE" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

# --- Periksa nilai status dan lakukan tindakan ---
if [ "$STATUS" == "true" ]; then
    echo ""
    echo "          MAINTENANCE         "
    echo "        UPDATE FUNCTION       "
    echo " You Can Run This Module Later "
    echo " You're Still On Version: $THIS_VERSION   "
    echo " And Latest Version:      $NEW_VERSION  "
    echo ""
    exit 0 # Keluar dengan sukses
elif [ "$STATUS" == "false" ]; then
    echo "Tidak ada pembaruan, melanjutkan instalasi..."
    curl -sL "$GITHUB_URL_INSTALL" -o "$DIR_INSTALL"
    chmod +x "$DIR_INSTALL"
    # Memanggil skrip install.sh
    # Gunakan 'bash' untuk memastikan eksekusi, atau '. ' jika ingin menjalankan di shell saat ini
    bash "$DIR_INSTALL" "$@" # Mengirimkan semua argumen ke install.sh
    # Opsi lain jika install.sh tidak butuh argumen awal: sh "$DIR_INSTALL"
    exit 0 # Keluar dengan sukses
else
    echo "Status tidak valid dalam file: '$LOCAL_STATUS_FILE'. Harap gunakan 'true' atau 'false'."
    exit 2 # Keluar dengan kode error
fi
