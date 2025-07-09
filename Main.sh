#!/bin/bash

# By Kazuyoo
for DIR in /data/data/*; do
  if [ -d "${DIR}" ]; then
    rm -rf ${DIR}/cache/*
    rm -rf ${DIR}/no_backup/*
    rm -rf ${DIR}/app_webview/*
    rm -rf ${DIR}/code_cache/*
  fi
done

# Delete Logs
{
rm -rf /data/{anr,log,tombstones,log_other_mode}/*
rm -rf /cache/*.{apk,tmp}
rm -rf /dev/log/*
rm -rf /data/system/{dropbox,usagestats,package_cache}/*
rm -rf /sys/kernel/debug/*
rm -rf /data/local/tmp*
rm -rf /data/dalvik-cache
rm -rf /data/media/0/{DCIM,Pictures,Music,Movies}/.thumbnails
rm -rf /data/media/0/{mtklog,MIUI/Gallery,MIUI/.debug_log,MIUI/BugReportCache}
rm -rf /data/vendor/thermal/{config,*.dump,*_history*.dump}
rm -rf /data/local/tmp/*
rm -rf /sdcard/Android/data/*/cache
} > /dev/null 2>&1

INSTALL_UPDATE_IN_PROGRESS="true"  # <--- SET INI KE "TRUE" DI GITHUB
UNINSTALL_UPDATE_IN_PROGRESS="true" # <--- SET INI KE "TRUE" DI GITHUB

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
    exit 1 # Keluar jika tidak dikenali
fi

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
        echo "--- Selesai menjalankan fungsi instalasi ---"
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
        echo "--- Selesai menjalankan fungsi uninstalasi ---"
    fi
fi
