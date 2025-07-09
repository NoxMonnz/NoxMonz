#!/bin/bash

STATUS_FILE="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/control.txt"
GITHUB_URL_INSTALL="https://raw.githubusercontent.com/NoxMonnz/NoxMonz/main/install.sh"
DIR_INSTALL="/data/local/tmp/install.sh"

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
        curl -sL "$GITHUB_URL_INSTALL" -o "$DIR_INSTALL"
        chmod +x "$DIR_INSTALL"
        . "$DIR_INSTALL" "$@"
        sh "$DIR_INSTALL"
    else
        echo "Status tidak valid dalam file: '$STATUS_FILE'. Harap gunakan 'true' atau 'false'."
        return 2
    fi
}
