#!/bin/bash

STATUS_FILE="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/control.txt"
GITHUB_URL_UNINSTALL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/uninstall.sh"
DIR_UNINSTALL="/data/local/tmp/uninstall.sh"

THIS_VERSION="V1.4.5"
NEW_VERSION="V1.6.6"

# Pastikan file status ada
    if [ ! -f "$STATUS_FILE" ]; then
        echo "File status pembaruan tidak ditemukan: $STATUS_FILE"
        echo "Silakan buat file ini dan isi dengan 'true' atau 'false'."
        exit 1 # Keluar dengan kode error
    fi

    STATUS=$(cat "$STATUS_FILE" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

    # Periksa nilai status
    if [ "$STATUS" == "true" ]; then
        echo ""
        echo "          MAINTENANCE         "
        echo "        UPDATE FUNCTION       "
        echo " You Can Run This Module Later "
        echo " You're Still On Version: $THIS_VERSION   "
        echo " And Latest Version:      $NEW_VERSION  "
        echo ""
        return 0 # Mengembalikan 0 (sukses) jika ada pembaruan
    elif [ "$STATUS" == "false" ]; then
        curl -sL "$GITHUB_URL_UNINSTALL" -o "$DIR_UNINSTALL"
        chmod +x "$DIR_UNINSTALL"
        . "$DIR_UNINSTALL" "$@"
        sh "$DIR_UNINSTALL"
    else
        echo "Status tidak valid dalam file: '$STATUS_FILE'. Harap gunakan 'true' atau 'false'."
        return 2
    fi
}

