#!/bin/bash

INSTALL_UPDATE_IN_PROGRESS="true"
UNINSTALL_UPDATE_IN_PROGRESS="true"
INSTALL_FUNCTION_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/install.sh"
DIR_INSTALL_FUNCTION="/data/local/tmp/install.sh"
UNINSTALL_FUNCTION_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/uninstall.sh"
DIR_UNINSTALL_FUNCTION="/data/local/tmp/uninstall.sh"

script_name=$(basename "$0")
current_dir=$(pwd) # Direktori saat ini dari mana skrip dijalankan

if [[ "$current_dir" == *"/exe_context"* ]]; then
    script_context="exe.sh"
elif [[ "$current_dir" == *"/rmv_context"* ]]; then
    script_context="rmv.sh"
else
    script_context="unknown"
    echo "Peringatan: Konteks skrip tidak dapat dideteksi dari jalur: $current_dir"
fi


if [[ "$script_context" == "exe.sh" ]]; then
    echo "Terdeteksi peluncuran: Konteks instalasi (EXE)"
    if [[ "$INSTALL_UPDATE_IN_PROGRESS" == "true" ]]; then
        echo "PEMBERITAHUAN: Fungsi instalasi NoxXB - PRO sedang dalam pembaruan"
        echo "Mohon coba lagi nanti."
    else
        echo "Tidak ada pembaruan untuk fungsi instalasi. Mengunduh dan menjalankan fungsi instalasi..."
        curl -sL "$INSTALL_FUNCTION_URL" -o "$DIR_INSTALL_FUNCTION"
        chmod +x "$DIR_INSTALL_FUNCTION"
        sh "$DIR_INSTALL_FUNCTION"
    fi
elif [[ "$script_context" == "rmv.sh" ]]; then
    echo "Terdeteksi peluncuran: Konteks uninstalasi (RMV)"
    if [[ "$UNINSTALL_UPDATE_IN_PROGRESS" == "true" ]]; then
        echo "PEMBERITAHUAN: Fungsi uninstalasi NoxXB - PRO sedang dalam pembaruan"
        echo "Mohon coba lagi nanti."
    else
        echo "Tidak ada pembaruan untuk fungsi uninstalasi. Mengunduh dan menjalankan fungsi uninstalasi..."
        curl -sL "$UNINSTALL_FUNCTION_URL" -o "$DIR_UNINSTALL_FUNCTION"
        chmod +x "$DIR_UNINSTALL_FUNCTION"
        sh "$DIR_UNINSTALL_FUNCTION"
    fi
else
    echo "Kesalahan: Tipe skrip tidak dikenali atau konteks tidak dapat ditentukan. Harusnya 'exe.sh' atau 'rmv.sh'."
fi
