#!/system/bin/sh

# Menambahkan direktori khusus
mkdir -p /data/local/tmp/sysui

# Argument link GitHub
GITHUB_FUNCTIONS_URL3="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/design.sh"
LOCAL_FUNCTIONS_FILE3="/data/local/tmp/sysui/design.sh"
GITHUB_FUNCTIONS_URL2="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/function-library.sh"
LOCAL_FUNCTIONS_FILE2="/data/local/tmp/sysui/function-library.sh"
GITHUB_FUNCTIONS_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/function-deleted.sh"
LOCAL_FUNCTIONS_FILE="/data/local/tmp/sysui/function-deleted.sh"

# Unduh file fungsi ke lokasi sementara
curl -sL "$GITHUB_FUNCTIONS_URL3" -o "$LOCAL_FUNCTIONS_FILE3"
curl -sL "$GITHUB_FUNCTIONS_URL2" -o "$LOCAL_FUNCTIONS_FILE2"
curl -sL "$GITHUB_FUNCTIONS_URL" -o "$LOCAL_FUNCTIONS_FILE"

# Verifikasi direktori dan file
chmod +x /data/local/tmp/sysui/design.sh
chmod +x /data/local/tmp/sysui/function-library.sh
chmod +x /data/local/tmp/sysui/function-deleted.sh

# Memulai fungsi file
source "/data/local/tmp/sysui/function-library.sh"
source "/data/local/tmp/sysui/function-deleted.sh"
source "/data/local/tmp/sysui/design.sh"

# Memulai Module NoxXB - PRO dengan function
sleep 0.2 && Detected_Game
sleep 0.2 && moddifier "$1"
sleep 0.2 && echo_design1
sleep 0.2 && echo_design
echo "-]÷————————————< Uninstalling >—————————————————— "
echo " "
sleep 2
echo "-  Removed Shell Script..."
sleep 2
sleep 0.2 && system_read_removed_function
sleep 0.2 && Removed_mode_vexz
sleep 0.2 && removed_cachecleaner
sleep 0.2 && battery
echo "-  Loading Process To Removed"
sleep 0.2 && network_default
sleep 0.2 && removed_optimize
sleep 0.2 && disable_render_optimize
sleep 0.2 && removed_game_driver
sleep 4
echo "-  Loading Final Shell To Removed"
sleep 0.2 && GarbageCleaner
sleep 0.2 && Trash
sleep 0.2 && removed_soc_optimize
sleep 0.2 && enable_gms
echo "-  Success Removed "
echo " "

Removed="$2"

case "$Removed" in
  -A)
    echo "-]÷————————————————< Reboot >——————————————————— "
    sleep 4
    sleep 0.2 && Reboot
    ;;
  *)
    echo "-]÷—————————————————< Done >———————————————————— "
    exit 1
    ;;
esac



