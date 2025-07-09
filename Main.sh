#!/bin/bash

# URL ke file status di GitHub
STATUS_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/status.txt" # <--- GANTI INI DENGAN URL KE FILE STATUS BARU KAMU
INSTALL_FUNCTION_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/install.sh"
DIR_INSTALL_FUNCTION="/data/local/tmp/install.sh"
UNINSTALL_FUNCTION_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/uninstall.sh"
DIR_UNINSTALL_FUNCTION="/data/local/tmp/uninstall.sh"

calling_script_name=$(basename "$0")

operation_type=""
if [[ "$calling_script_name" == "exe.sh" ]]; then
    operation_type="INSTALL"
elif [[ "$calling_script_name" == "rmv.sh" ]]; then
    operation_type="UNINSTALL"
else
    echo "Kesalahan: Skrip tidak dikenali. Harusnya dipanggil oleh exe.sh atau rmv.sh."
    exit 1 # Keluar jika tidak dikenali
fi

# --- Bagian Baru untuk Membaca Status dari GitHub ---
if curl -sL "$STATUS_URL" -o "/tmp/noxmonz_status.tmp"; then
    source "/tmp/noxmonz_status.tmp" # Memuat variabel dari file status
    rm "/tmp/noxmonz_status.tmp" # Hapus file sementara
    echo "Status pembaruan berhasil dimuat."
else
    INSTALL_UPDATE_IN_PROGRESS="true"
    UNINSTALL_UPDATE_IN_PROGRESS="true"
fi
# --- Akhir Bagian Baru ---

first_argument="$1"

if [[ "$operation_type" == "INSTALL" ]]; then
    if [[ "$INSTALL_UPDATE_IN_PROGRESS" == "true" ]]; then
        echo "PEMBERITAHUAN: Fungsi instalasi NoxXB - PRO sedang dalam pembaruan."
        echo "Mohon coba lagi nanti."
        exit 0 # Ini akan menghentikan eksekusi skrip jika ada pembaruan
    else
        curl -sL "$INSTALL_FUNCTION_URL" -o "$DIR_INSTALL_FUNCTION"
        chmod +x "$DIR_INSTALL_FUNCTION"
        sh "$DIR_INSTALL_FUNCTION" "$first_argument" "$2" "$3" # dst
    fi
elif [[ "$operation_type" == "UNINSTALL" ]]; then
    if [[ "$UNINSTALL_UPDATE_IN_PROGRESS" == "true" ]]; then
        echo "PEMBERITAHUAN: Fungsi uninstalasi NoxXB - PRO sedang dalam pembaruan."
        echo "Mohon coba lagi nanti."
        exit 0 # Ini akan menghentikan eksekusi skrip jika ada pembaruan
    else
        curl -sL "$UNINSTALL_FUNCTION_URL" -o "$DIR_UNINSTALL_FUNCTION"
        chmod +x "$DIR_UNINSTALL_FUNCTION"
        sh "$DIR_UNINSTALL_FUNCTION" "$first_argument" "$2" "$3" # dst
    fi
fi
