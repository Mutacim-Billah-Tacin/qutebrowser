# Load Bitwarden session token automatically if cached
if test -f ~/.cache/bw-session
    set -gx BW_SESSION (cat ~/.cache/bw-session)
end
