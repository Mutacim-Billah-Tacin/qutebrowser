function bw-login
    set -gx BW_SESSION (bw unlock --raw)
    echo $BW_SESSION >~/.cache/bw-session
    echo "Bitwarden unlocked and session saved!"
end
