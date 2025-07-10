#!/bin/sh

NOXXBPRO_BASE_DIR="/storage/emulated/0/NoxXBPRO"
SETTINGS_DIR="$NOXXBPRO_BASE_DIR/settings" 
CONFIG_FILE="$SETTINGS_DIR/update_status.conf" 
TEMP_DIR="/data/local/tmp" 

GITHUB_REPO_RAW_URL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main"
GITHUB_VERSION_URL="$GITHUB_REPO_RAW_URL/version.txt"
INSTALL_SCRIPT_URL="$GITHUB_REPO_RAW_URL/install.sh"
UNINSTALL_SCRIPT_URL="$GITHUB_REPO_RAW_URL/uninstall.sh"

download_and_exec() {
    local url="$1"
    local temp_path="$2"
    local args="${@:3}"

    echo "Mengunduh: $url ke $temp_path"
    curl -sL "$url" -o "$temp_path"

    if [ ! -f "$temp_path" ]; then
        echo "ERROR: Gagal mengunduh script dari $url."
        return 1
    fi

    chmod +x "$temp_path"
    sh "$temp_path" $args # Jalankan script
    local exit_code=$?
    rm -f "$temp_path" # Hapus script sementara setelah selesai
    return $exit_code
}

check_for_update() {
    # Pastikan direktori settings ada
    mkdir -p "$SETTINGS_DIR"

    # 1. Unduh versi terbaru dari GitHub
    LATEST_GITHUB_VERSION=$(curl -sL "$GITHUB_VERSION_URL")

    if [ -z "$LATEST_GITHUB_VERSION" ]; then
        echo "PERINGATAN: Gagal mendapatkan versi terbaru dari GitHub. Cek koneksi internet atau URL."
        return 1
    fi

    # 2. Baca versi lokal dari update_status.conf
    LOCAL_INSTALLED_VERSION="0.0.0" # Default jika file tidak ada atau kosong
    if [ -f "$CONFIG_FILE" ]; then
        LOCAL_VERSION_LINE=$(grep "VERSION=" "$CONFIG_FILE" 2>/dev/null)
        if [ -n "$LOCAL_VERSION_LINE" ]; then
            LOCAL_INSTALLED_VERSION=$(echo "$LOCAL_VERSION_LINE" | cut -d '=' -f 2 | tr -d '"')
        fi
    fi

    echo "Versi GitHub terbaru: $LATEST_GITHUB_VERSION"
    echo "Versi terinstal lokal: $LOCAL_INSTALLED_VERSION"

    compare_versions() {
        local v1="$1"
        local v2="$2"
        echo "$v1 $v2" | awk '{
            split($1, a, "."); split($2, b, ".");
            for (i=1; i<=3; i++) {
                if (a[i] > b[i]) { print 1; exit; } # v1 lebih besar
                if (a[i] < b[i]) { print -1; exit; } # v1 lebih kecil
            }
            print 0; # sama
        }'
    }

    VERSION_COMPARE_RESULT=$(compare_versions "$LOCAL_INSTALLED_VERSION" "$LATEST_GITHUB_VERSION")

    if [ "$VERSION_COMPARE_RESULT" = "-1" ]; then
        echo "PENTING: Ada pembaruan tersedia untuk NoxXBPRO! Direkomendasikan untuk update."
        return 0 # Ada update
    else
        echo "Modul NoxXBPRO Anda sudah versi terbaru."
        return 1 # Tidak ada update (sama atau lebih baru)
    fi
}

# --- Fungsi untuk memperbarui versi lokal di update_status.conf ---
update_local_version() {
    local new_version="$1"
    echo "VERSION=\"$new_version\"" > "$CONFIG_FILE"
    echo "Versi modul lokal di $CONFIG_FILE telah diperbarui ke: $new_version"
}

# --- Eksekusi Utama Main.sh ---
MODE="$1" # Argumen: 'install' atau 'uninstall'

echo "Memulai operasi NoxXBPRO..."

# Selalu cek update setiap kali Main.sh dijalankan
check_for_update
UPDATE_NEEDED=$? # Status dari check_for_update (0 = ada update, 1 = tidak ada / gagal)

# Tanya pengguna jika ada update dan mereka menjalankan instalasi
if [ "$MODE" = "install" ]; then
    if [ $UPDATE_NEEDED -eq 0 ]; then
        read -p "Versi baru tersedia. Lanjutkan instalasi dengan versi ini? (y/n): " confirm
        if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
            echo "Instalasi dibatalkan oleh pengguna."
            exit 1
        fi
    fi

    echo "Melanjutkan proses instalasi..."
    # Unduh dan jalankan install.sh dari GitHub ke direktori sementara
    download_and_exec "$INSTALL_SCRIPT_URL" "$TEMP_DIR/install_noxxbpro.sh"
    INSTALL_EXIT_CODE=$?

    if [ $INSTALL_EXIT_CODE -eq 0 ]; then
        # Setelah instalasi berhasil, perbarui versi lokal
        LATEST_GITHUB_VERSION_AFTER_INSTALL=$(curl -sL "$GITHUB_VERSION_URL")
        update_local_version "$LATEST_GITHUB_VERSION_AFTER_INSTALL"
        echo "Instalasi NoxXBPRO selesai."
    else
        echo "ERROR: Instalasi NoxXBPRO gagal."
        exit 1
    fi

elif [ "$MODE" = "uninstall" ]; then
    echo "Melanjutkan proses penghapusan..."
    download_and_exec "$UNINSTALL_SCRIPT_URL" "$TEMP_DIR/uninstall_noxxbpro.sh"
    UNINSTALL_EXIT_CODE=$?

    if [ $UNINSTALL_EXIT_CODE -eq 0 ]; then
        update_local_version "0.0.0" # Reset versi
        echo "Penghapusan NoxXBPRO selesai."
    else
        echo "ERROR: Penghapusan NoxXBPRO gagal."
        exit 1
    fi
else
    echo "Penggunaan: sh Main.sh [install|uninstall]"
    echo "Script ini seharusnya dipanggil oleh exe.sh atau rmv.sh."
    exit 1
fi
