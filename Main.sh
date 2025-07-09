#!/bin/bash

MAIN_SCRIPT_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/Main.sh"
INSTALL_FUNCTION_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/install.sh"
DIR_INSTALL_FUNCTION="/data/local/tmp/install.sh"
UNINSTALL_FUNCTION_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/uninstall.sh"
DIR_UNINSTALL_FUNCTION="/data/local/tmp/uninstall.sh"

INSTALL_UPDATE_IN_PROGRESS="true"
UNINSTALL_UPDATE_IN_PROGRESS="true"

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

REMOTE_MAIN_SCRIPT_CONTENT=$(curl -sL "$MAIN_SCRIPT_URL")

if [ -n "$REMOTE_MAIN_SCRIPT_CONTENT" ]; then
    # Ekstrak nilai INSTALL_UPDATE_IN_PROGRESS_GH
    INSTALL_STATUS_LINE=$(echo "$REMOTE_MAIN_SCRIPT_CONTENT" | grep 'INSTALL_UPDATE_IN_PROGRESS_GH=')
    if [ -n "$INSTALL_STATUS_LINE" ]; then
        INSTALL_UPDATE_IN_PROGRESS=$(echo "$INSTALL_STATUS_LINE" | cut -d'=' -f2 | tr -d ' ' | tr -d '"')
    else
        echo "Peringatan: Gagal menemukan variabel INSTALL_UPDATE_IN_PROGRESS_GH di remote Main.sh."
    fi

    # Ekstrak nilai UNINSTALL_UPDATE_IN_PROGRESS_GH
    UNINSTALL_STATUS_LINE=$(echo "$REMOTE_MAIN_SCRIPT_CONTENT" | grep 'UNINSTALL_UPDATE_IN_PROGRESS_GH=')
    if [ -n "$UNINSTALL_STATUS_LINE" ]; then
        UNINSTALL_UPDATE_IN_PROGRESS=$(echo "$UNINSTALL_STATUS_LINE" | cut -d'=' -f2 | tr -d ' ' | tr -d '"')
    else
        echo "Peringatan: Gagal menemukan variabel UNINSTALL_UPDATE_IN_PROGRESS_GH di remote Main.sh."
    fi

    echo "Status pembaruan berhasil dimuat: INSTALL_UPDATE_IN_PROGRESS=$INSTALL_UPDATE_IN_PROGRESS, UNINSTALL_UPDATE_IN_PROGRESS=$UNINSTALL_UPDATE_IN_PROGRESS"
else
    echo "Peringatan: Gagal mengambil konten Main.sh dari GitHub. Melanjutkan dengan nilai default."
    # Variabel INSTALL_UPDATE_IN_PROGRESS dan UNINSTALL_UPDATE_IN_PROGRESS akan tetap menggunakan nilai default
fi

first_argument="$1"

if [[ "$operation_type" == "INSTALL" ]]; then
    if [[ "$INSTALL_UPDATE_IN_PROGRESS" == "true" ]]; then
        echo "PEMBERITAHUAN: Fungsi instalasi NoxXB - PRO sedang dalam pembaruan."
        echo "Mohon coba lagi nanti."
        exit 0 # Ini akan menghentikan eksekusi skrip jika ada pembaruan
    else
        echo "Melanjutkan instalasi..."
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
        echo "Melanjutkan uninstalasi..."
        curl -sL "$UNINSTALL_FUNCTION_URL" -o "$DIR_UNINSTALL_FUNCTION"
        chmod +x "$DIR_UNINSTALL_FUNCTION"
        sh "$DIR_UNINSTALL_FUNCTION" "$first_argument" "$2" "$3" # dst
    fi
fi
