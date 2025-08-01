#!/usr/bin/env bash

SESSION_FILE="$HOME/.cache/bw-session"

if [ -z "$BW_SESSION" ]; then
  if [ -f "$SESSION_FILE" ]; then
    export BW_SESSION=$(cat "$SESSION_FILE")
  else
    echo "BW_SESSION not set and no session file found."
    echo "Run: bw unlock --raw > ~/.cache/bw-session"
    exit 1
  fi
fi

URL="$1"
if [ -z "$URL" ]; then
  echo "No URL passed to the script!"
  exit 1
fi

DOMAIN=$(echo "$URL" | awk -F/ '{print $3}' | sed 's/^www\.//')

mapfile -t choices < <(bw list items --search "$DOMAIN" --session "$BW_SESSION" | jq -r '.[] | "\(.id) \(.login.username // "no-username") \(.name)"')

if [ ${#choices[@]} -eq 0 ]; then
  echo "No Bitwarden items found for domain: $DOMAIN"
  exit 1
fi

selected=$(printf '%s\n' "${choices[@]}" | fzf --prompt="Select login for $DOMAIN: " | awk '{print $1}')

if [ -z "$selected" ]; then
  echo "No login selected."
  exit 1
fi

ITEM_JSON=$(bw get item "$selected" --session "$BW_SESSION")

USERNAME=$(echo "$ITEM_JSON" | jq -r '.login.username // empty')
PASSWORD=$(echo "$ITEM_JSON" | jq -r '.login.password // empty')

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
  echo "No username or password found in Bitwarden entry."
  exit 1
fi

# Copy to clipboard
echo "$USERNAME" | wl-copy
sleep 0.5
echo "$PASSWORD" | wl-copy -n

# Auto-type with wtype (Wayland-safe)
sleep 0.5
wtype "$USERNAME"
wtype -k Tab
wtype "$PASSWORD"

notify-send "Bitwarden" "Username and password typed & copied!"
