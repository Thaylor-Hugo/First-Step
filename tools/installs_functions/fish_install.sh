#!/bin/bash

# Install fish shell
install_fish() {
    sudo apt-get install fish -y >> log/install.log
    sudo chsh -s $(which fish) >> log/install.log
    mkdir -p ~/.config/fish
    cp -f config/config.fish ~/.config/fish/
    # yes | curl -L https://get.oh-my.fish | fish >> log/install.log
    # omf install bass >> log/install.log
}

