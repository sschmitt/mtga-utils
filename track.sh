#!/bin/bash

WINE_PREFIX="/home/$USER/Games/magic-the-gathering-arena2"

export ProgramFiles="$WINE_PREFIX/drive_c/Program Files (x86)"
export APPDATA="$WINE_PREFIX/drive_c/users/$USER/AppData/LocalLow"

track() {
    local dir="$1"
    local new_file="$2"
    local option="$3"
    local redirect="$4"

    mkdir -p "$dir"

    latest_file=$(ls "$dir" | tail -1)

    if [[ "$redirect" = "true" ]]; then
        python mtga-export.py $option > "$dir/$new_file"
    else
        python mtga-export.py $option -f "$dir/$new_file"
    fi
    echo "Exported to file: $dir/$new_file"

    if [[ -n "$latest_file" ]]; then
        echo "Diff with prior file: $dir/$latest_file"
        diff "$dir/$latest_file" "$dir/$new_file"
    fi
}

logdir="history"
filename=$(date -u '+%FT%TZ')

track "$logdir/collection" "$filename" -gf
track "$logdir/inventory" "$filename" -i true
