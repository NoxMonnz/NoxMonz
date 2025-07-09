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
GITHUB_FUNCTIONS_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/function-deleted.sh"
LOCAL_FUNCTIONS_FILE="/data/local/tmp/function-deleted.sh"

# Unduh file fungsi ke lokasi sementara
curl -sL "$GITHUB_FUNCTIONS_URL3" -o "$LOCAL_FUNCTIONS_FILE3"
curl -sL "$GITHUB_FUNCTIONS_URL" -o "$LOCAL_FUNCTIONS_FILE"

# Verifikasi direktori dan file
chmod +x /data/local/tmp/design.sh
chmod +x /data/local/tmp/function-deleted.sh

# Memulai fungsi file
source "/data/local/tmp/function-deleted.sh"
source "/data/local/tmp/design.sh"

sleep 0.2 && echo_design1
sleep 0.2 && echo_design
sleep 2
echo " Removed Shell Script..."
sleep 2
sleep 0.2 && system_read_removed_function
sleep 0.2 && Removed_mode_vexz
sleep 0.2 && removed_cachecleaner
sleep 0.2 && battery
echo " Loading Process To Removed"
sleep 0.2 && network_default
sleep 0.2 && removed_optimize
sleep 0.2 && disable_render_optimize
sleep 0.2 && removed_game_driver
sleep 4
echo " Loading Final Shell To Removed"
sleep 0.2 && GarbageCleaner
sleep 0.2 && Trash
sleep 0.2 && removed_soc_optimize
sleep 0.2 && enable_gms
echo " Success Removed "
echo ""
sleep 4

Removed="$1"

case "$Removed" in
  -Half)
    # Not Found
    exit 1
    ;;
  -All)
    sleep 0.2 && Reboot
    ;;
esac