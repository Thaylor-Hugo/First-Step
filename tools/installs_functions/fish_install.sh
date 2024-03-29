#!/bin/bash

# Install fish shell
install_fish() {
    local title="Installing 'Fish - Interactive shell'..."
    local gum_spin='gum spin --spinner line --title'
    $gum_spin "$title" -- sudo apt-get install fish -y >> log/install.log
    $gum_spin "$title" -- sudo chsh -s $(which fish) >> log/install.log
    mkdir -p ~/.config/fish
    cp -f config/config.fish ~/.config/fish/
    # yes | curl -L https://get.oh-my.fish | fish >> log/install.log
    # omf install bass >> log/install.log
}
