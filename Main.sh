#!/bin/bash

# Setel ke 'true' jika fungsi instalasi sedang diperbarui
INSTALL_UPDATE_IN_PROGRESS="true"
# Setel ke 'true' jika fungsi uninstalasi sedang diperbarui
UNINSTALL_UPDATE_IN_PROGRESS="true"

# --- URL GITHUB FUNGSI (GANTI DENGAN URL REPO ANDA) ---
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

first_argument="$1" # Ini akan menjadi "com.dts.freefiremax" dalam contoh Anda

if [[ "$operation_type" == "INSTALL" ]]; then    
    if [[ "$INSTALL_UPDATE_IN_PROGRESS" == "true" ]]; then
        echo "PEMBERITAHUAN: Fungsi instalasi NoxXB - PRO sedang dalam pembaruan."
        echo "Mohon coba lagi nanti."
        exit 1 # Keluar dari skrip dengan status sukses (0) karena sudah memberitahu user.**
    else        
        curl -sL "$INSTALL_FUNCTION_URL" -o "$DIR_INSTALL_FUNCTION"
        chmod +x "$DIR_INSTALL_FUNCTION"
        sh "$DIR_INSTALL_FUNCTION" "$first_argument" "$2" "$3" # dst, teruskan semua argumen        
    fi
elif [[ "$operation_type" == "UNINSTALL" ]]; then    
    if [[ "$UNINSTALL_UPDATE_IN_PROGRESS" == "true" ]]; then
        echo "PEMBERITAHUAN: Fungsi uninstalasi NoxXB - PRO sedang dalam pembaruan."
        echo "Mohon coba lagi nanti."
        exit 1 # Keluar dari skrip dengan status sukses (0) karena sudah memberitahu user.**
    else       
        curl -sL "$UNINSTALL_FUNCTION_URL" -o "$DIR_UNINSTALL_FUNCTION"
        chmod +x "$DIR_UNINSTALL_FUNCTION"
        sh "$DIR_UNINSTALL_FUNCTION" "$first_argument" "$2" "$3" # dst, teruskan semua argumen       
    fi
fi