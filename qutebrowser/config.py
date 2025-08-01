# Load autoconfig settings (required at top)
config.load_autoconfig()

# Extra adblock lists to add on top of GUI defaults
extra_lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
]

existing_lists = config.get("content.blocking.adblock.lists") or []
combined_lists = existing_lists + extra_lists
config.set("content.blocking.adblock.lists", combined_lists)

# Enable dark mode
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "smart")
config.set("colors.webpage.darkmode.policy.page", "always")

# Enable JavaScript
config.set("content.javascript.enabled", True)

# Use adblock if you have python-adblock installed
config.set("content.blocking.method", "adblock")

# Show tabs only when multiple tabs are open
config.set("tabs.show", "multiple")

# Keybinds (Vim style)
config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind(",m", "spawn vlc {url}")
config.bind("xx", "tab-close")

# Yank URL
config.bind("yu", "yank")

# Bitwarden
config.bind(",b", "spawn --userscript ~/.local/share/qutebrowser/userscripts/bw-autofill.sh {url}")
