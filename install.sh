#!/system/bin/sh

# Menambahkan direktori khusus
mkdir -p /data/local/tmp/sysui

# Argument link GitHub
GITHUB_FUNCTIONS_URL3="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/design.sh"
LOCAL_FUNCTIONS_FILE3="/data/local/tmp/sysui/design.sh"
GITHUB_FUNCTIONS_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/function-library.sh"
LOCAL_FUNCTIONS_FILE="/data/local/tmp/sysui/function-library.sh"
GITHUB_FUNCTIONS_URL2="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/function-library2.sh"
LOCAL_FUNCTIONS_FILE2="/data/local/tmp/sysui/function-library2.sh"

# Unduh file fungsi ke lokasi sementara
curl -sL "$GITHUB_FUNCTIONS_URL3" -o "$LOCAL_FUNCTIONS_FILE3"
curl -sL "$GITHUB_FUNCTIONS_URL" -o "$LOCAL_FUNCTIONS_FILE"
curl -sL "$GITHUB_FUNCTIONS_URL2" -o "$LOCAL_FUNCTIONS_FILE2"

# Verifikasi direktori dan file
chmod +x /data/local/tmp/sysui/design.sh
chmod +x /data/local/tmp/sysui/function-library.sh
chmod +x /data/local/tmp/sysui/function-library2.sh

# Memulai fungsi file
source "/data/local/tmp/sysui/function-library.sh"
source "/data/local/tmp/sysui/function-library2.sh"
source "/data/local/tmp/sysui/design.sh"

# Memulai Module NoxXB - PRO dengan function
sleep 0.2 && Detected_Game
sleep 0.2 && moddifier "$1"
sleep 0.2 && Checking_file
sleep 0.2 && echo_design1
sleep 0.2 && echo_design
echo "-]÷——————————————< Installing >————————————————— "
echo " "
sleep 1.5
echo "-  Running Shell Script... "
sleep 0.2 && Mode_Vexz
sleep 0.2 && cache_cleaner
sleep 0.2 && optimize
sleep 0.2 && disable_battery
echo "-  Loading Process "
sleep 0.2 && network_booster
sleep 0.2 && game_driver
sleep 0.2 && SOC
sleep 4.2 && SF
echo "-  Loading Final Shell "
sleep 0.2 && GMS
sleep 0.2 && GarbageCleaner
sleep 0.2 && Trash
sleep 0.2 && system_read_function "$1"
echo " "
echo "-]÷—————————————————< Done >———————————————————— "
sleep 0.2 && Launcher_game
