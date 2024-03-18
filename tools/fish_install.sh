#!/bin/bash

# Install fish shell
install_fish() {
    apt-get install fish -y >> log/install.log
    chsh -s $(which fish) >> log/install.log
    yes | curl -L https://get.oh-my.fish | fish >> log/install.log
    omf install bass >> log/install.log
    echo "bass source /opt/ros/iron/setup.bash" >> ~/.config/fish/config.fish
}
