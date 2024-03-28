#!/bin/bash

# Check if the user is root
if [ `whoami` == 'root' ]; then
    echo "Please re-run without sudo command."
    exit 1
fi

# Print with root for the user to enter the password only once
sudo echo "Initiating Install and Config"

# Source the install file
source tools/install.sh

install_gum() {
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt-get update && sudo apt-get install gum -y
}

# Function to install the dependencies
install_dep() {
    echo "Installing gum..."
    install_gum >> log/install.log

    local title="Installing the dependencies..."
    local gum_spin='gum spin --spinner line --title'
        
    $gum_spin "$title" -- sudo apt-get install xclip -y >> log/install.log
    $gum_spin "$title" -- sudo apt-get install curl -y >> log/install.log
    $gum_spin "$title" -- sudo apt-get install unzip -y >> log/install.log

    echo "Dependencies installed!"
}

# Define the checklist items
programing_list=(   "Git - Version control system" \
                    "Fish - Interactive shell" \
                    "GCC - GNU Compiler Collection" \
                    "Make - Build tool" \
                    "CMake - Build system generator" \
                    "VSCode - Feature-rich code editor" \
                    "ROS2 - Robotics framework" \
                    "JLink - JLink tools" \
                    "STM32Cube - CubeProgrammer, CubeMX and CubeMonitor" \
                    "ARM-GCC - Compiler for ARM processors")

useful_list=(   "Discord - Communication platform" \
                "VLC - Media player" \
                "CopyQ - Clipboard manager" \
                "Baobab - Disk usage analiser" \
                "Charge Rules - Auto change power profile")

# Function to display the checklist
display_checklist() {
    # Display the checklist for programming items
    clear
    gum style \
        --foreground 212 --border-foreground 212 --border double \
        --align center --width 50 --margin "1 2" --padding "2 4" \
        "Install and Configure Programming Items" 'Choose the items you would like!'
    local selected_programing_items=$(gum choose --no-limit "${programing_list[@]}")
    check_cancel

    # Display the checklist for useful items
    clear    
    gum style \
        --foreground 212 --border-foreground 212 --border double \
        --align center --width 50 --margin "1 2" --padding "2 4" \
        "Install and Configure Useful Items" 'Choose the items you would like!'
    local selected_useful_items=$(gum choose --no-limit "${useful_list[@]}")
    check_cancel

    local IFS=$'\n'
    selected_programing_items=($selected_programing_items)
    selected_useful_items=($selected_useful_items)

    choices=("${selected_programing_items[@]}" "${selected_useful_items[@]}")
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

# Main script
main() {
    create_log
    install_dep

    display_checklist

    clear
    echo "Installing and configuring the selected items..."
    echo -e "This may take a while... \n"

    # Install the selected items
    install_packages "${choices[@]}"

    # Update and upgrade the system
    sudo apt-get update >> log/install.log
    sudo apt-get upgrade -y >> log/install.log

    echo "Installation Done! Please reboot to finish configuration"
    read -p "Reboot now? (y) or (n)..."
    if [ $REPLY = "y" ]; then
        reboot
    fi
    exit 0
}

main