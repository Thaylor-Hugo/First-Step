#!/bin/bash

# Function to set the extension URL
# First argument is the extension name
set_extension_url() {
    case "$@" in
        "Battery Health Charging - Battery health and charging information")
            EXTENSION_URL="https://extensions.gnome.org/extension/5724/battery-health-charging/" ;;
        "Blur My Shell - Blur the shell background and lock screen")
            EXTENSION_URL="https://extensions.gnome.org/extension/3193/blur-my-shell/" ;;
        "Caffeine - Prevent the activation of the screensaver")
            EXTENSION_URL="https://extensions.gnome.org/extension/517/caffeine/" ;;
        "Clipboard Indicator - Clipboard manager")
            EXTENSION_URL="https://extensions.gnome.org/extension/779/clipboard-indicator/" ;;
        "Dash to Dock - Move the dash out of the overview transforming it in a dock")
            EXTENSION_URL="https://extensions.gnome.org/extension/307/dash-to-dock/" ;;
        "Extension List - Manage GNOME Shell extensions")
            EXTENSION_URL="https://extensions.gnome.org/extension/3088/extension-list/" ;;
        "GNOME 40 UI Improvements - GNOME 40 UI Improvements")
            EXTENSION_URL="https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/" ;;
        "GSConnect - KDE Connect implementation for GNOME")
            EXTENSION_URL="https://extensions.gnome.org/extension/1319/gsconnect/" ;;
        "Impatience - Speed up the GNOME Shell animations")
            EXTENSION_URL="https://extensions.gnome.org/extension/277/impatience/" ;;
        "Net Speed Simplified - Display the network speed")
            EXTENSION_URL="https://extensions.gnome.org/extension/3724/net-speed-simplified/" ;;
        "Order Gnome Shell Extensions - Order Gnome Shell Extensions")
            EXTENSION_URL="https://extensions.gnome.org/extension/2114/order-gnome-shell-extensions/" ;;
        "Refresh WiFi Connections - Refresh WiFi Connections")
            EXTENSION_URL="https://extensions.gnome.org/extension/905/refresh-wifi-connections/" ;;
        "Sound Output Device Chooser - Sound Output Device Chooser")
            EXTENSION_URL="https://extensions.gnome.org/extension/906/sound-output-device-chooser/" ;;
        "User Themes - User Themes")
            EXTENSION_URL="https://extensions.gnome.org/extension/19/user-themes/" ;;
        "Vitals - System monitoring")
            EXTENSION_URL="https://extensions.gnome.org/extension/1460/vitals/" ;;
        "WinTile - Windows 10 window tiling for GNOME")
            EXTENSION_URL="https://extensions.gnome.org/extension/1723/wintile-windows-10-window-tiling-for-gnome/" ;;
    esac
}

# Install gnome extensions
# First argument is the list of extensions
install_gnome_extensions() {
    local gum_spin='gum spin --spinner line --title'
    
    $gum_spin "Installing Extionsions dependences..." -- sudo apt-get install jq -y
    $gum_spin "Installing Extionsions dependences..." -- sudo apt-get install chrome-gnome-shell -y

    local extensions=("$@")
    for i in "${extensions[@]}"; do
        local title="Installing '$i'..."
        set_extension_url $i

        EXTENSION_ID=$(curl -s $EXTENSION_URL | grep -oP 'data-uuid="\K[^"]+')
        VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
        $gum_spin "Downloading Extension $i" -- wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
        $gum_spin "Installing Extension $i" -- gnome-extensions install --force ${EXTENSION_ID}.zip
        if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
            $gum_spin "Installing Extension $i" -- busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
        fi
        $gum_spin "Installing Extension $i" -- gnome-extensions enable ${EXTENSION_ID}
        sudo rm ${EXTENSION_ID}.zip
        
        echo -e "$i installed! \n" 
    done
}
