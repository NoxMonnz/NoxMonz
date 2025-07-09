#!/system/bin/sh

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

# Argument link GitHub
GITHUB_FUNCTIONS_URL3="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/design.sh"
LOCAL_FUNCTIONS_FILE3="/data/local/tmp/design.sh"
GITHUB_FUNCTIONS_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/function-library.sh"
LOCAL_FUNCTIONS_FILE="/data/local/tmp/function-library.sh"
GITHUB_FUNCTIONS_URL2="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/function-library2.sh"
LOCAL_FUNCTIONS_FILE2="/data/local/tmp/function-library2.sh"

# Unduh file fungsi ke lokasi sementara
curl -sL "$GITHUB_FUNCTIONS_URL3" -o "$LOCAL_FUNCTIONS_FILE3"
curl -sL "$GITHUB_FUNCTIONS_URL" -o "$LOCAL_FUNCTIONS_FILE"
curl -sL "$GITHUB_FUNCTIONS_URL2" -o "$LOCAL_FUNCTIONS_FILE2"

# Verifikasi direktori dan file
chmod +x /data/local/tmp/design.sh
chmod +x /data/local/tmp/function-library.sh
chmod +x /data/local/tmp/function-library2.sh

# Memulai fungsi file
source "/data/local/tmp/function-library.sh"
source "/data/local/tmp/function-library2.sh"
source "/data/local/tmp/design.sh"

# Memulai Module NoxXB - PRO dengan function
sleep 0.2 && Delete_log
sleep 0.2 && Detected_Game
sleep 0.2 && moddifier "$1"
sleep 0.2 && Checking_file
sleep 0.2 && echo_design1
sleep 0.2 && echo_design
sleep 2
echo " Running Shell Script... "
sleep 0.2 && Mode_Vexz
sleep 0.2 && cache_cleaner
sleep 0.2 && optimize
sleep 0.2 && disable_battery
sleep 2
echo " Loading Process "
sleep 0.2 && network_booster
sleep 0.2 && game_driver
sleep 0.2 && SOC
sleep 0.2 && SF
sleep 4
echo " Loading Final Shell "
sleep 0.2 && GMS
sleep 0.2 && GarbageCleaner
sleep 0.2 && Trash
sleep 0.2 && system_read_function "$1"
sleep 1
sleep 0.2 && Launcher_game
