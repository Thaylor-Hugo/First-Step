#!/bin/bash

# Function to install gum
install_gum() {
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt-get update && sudo apt-get install gum -y
}

# Function to install the dependencies
install_dep() {
    if [[ -z $(which curl) ]]; then 
        echo "Installing curl..."
        $gum_spin "$title" -- sudo apt-get install curl -y >> log/install.log
    fi
    if [[ -z $(which gum) ]]; then
        echo "Installing gum..."
        install_gum >> log/install.log
    fi

    local title="Installing the dependencies..."
    local gum_spin='gum spin --spinner line --title'
    
    if [[ -z $(which xclip) ]]; then 
        $gum_spin "$title" -- sudo apt-get install xclip -y >> log/install.log
    fi
    if [[ -z $(which unzip) ]]; then 
        $gum_spin "$title" -- sudo apt-get install unzip -y >> log/install.log
    fi

    echo "Dependencies installed!"
}

# Function to check if the user canceled the operation
check_cancel() {
    if [ $? -eq 1 ] || [ $? -eq 255 ]; then
        clear
        echo "Exiting..."
        exit 0
    fi
}

# Create the log directory and file
create_log() {
    mkdir -p log
    touch log/install.log
    echo "" > log/install.log
}