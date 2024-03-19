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

# Function to install the dependencies
install_dep() {
    sudo apt-get install xclip -y >> log/install.log
    sudo apt-get install curl -y >> log/install.log
    sudo apt-get install dialog -y >> log/install.log
    sudo apt-get install unzip -y >> log/install.log
}

# Define the checklist items
programing_list=(   "Git" "Version control system" "off" \
                    "Fish" "Interactive shell" "off" \
                    "GCC" "GNU Compiler Collection" "off" \
                    "Make" "Build tool" "off" \
                    "CMake" "Build system generator" "off" \
                    "VSCode" "Feature-rich code editor" "off" \
                    "ROS2" "Robotics framework" "off" \
                    "JLink" "JLink tools" "off" \
                    "STM32Cube" "CubeProgrammer, CubeMX and CubeMonitor" "off"
                    "ARM-GCC" "Compiler for ARM processors." "off")

useful_list=(   "Discord" "Communication platform" "off" \
                "VLC" "Media player" "off" \
                "CopyQ" "Clipboard manager" "off" \
                "Baobab" "Disk usage analiser" "off")

# Function to display the checklist
# First argument is the title
# Second argument is the list of items
display_checklist() {
    local title=$1
    shift
    local items=("$@")
    dialog --clear --checklist "$title" 0 0 ${#items[@]} "${items[@]}" 2>&1 >/dev/tty
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
    echo "Installing the dependencies..."
    install_dep

    selected_programing_items=$(display_checklist "Install and Configure Programming Items" "${programing_list[@]}")
    check_cancel
    selected_useful_items=$(display_checklist "Install and Configure Useful Items" "${useful_list[@]}")
    check_cancel

    all_selected_items=($selected_programing_items $selected_useful_items)

    clear
    echo "Installing and configuring the selected items..."
    echo -e "This may take a while... \n"

    # Install the selected items
    install_packages "${all_selected_items[@]}"

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