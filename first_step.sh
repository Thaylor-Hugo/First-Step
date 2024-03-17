#!/bin/bash

# Check if the user is root
if [ `whoami` != 'root' ]; then
    echo "Root privileges are required for this operation. Please re-run with sudo command."
    exit 1
fi

# Source the install file
source tools/install.sh

install_dep() {
    apt-get install xclip -y >> log/install.log
    apt-get install curl -y >> log/install.log
    apt-get install dialog -y >> log/install.log
}

# Define the checklist items
programing_list=(   "Git" "Version control system" "off" \
                    "Fish" "Interactive shell" "off" \
                    "Make" "Build tool" "off" \
                    "CMake" "Build system generator" "off" \
                    "VSCode" "Feature-rich code editor" "off" \
                    "ROS2" "Robotics framework" "off" \
                    "STM32Cube" "CubeProgrammer, CubeMX and CubeMonitor" "off")

useful_list=(   "Discord" "Communication platform" "off" \
                "VLC" "Media player" "off" \
                "CopyQ" "Clipboard manager" "off" \
                "Baobab" "Disk usage analiser" "off" \
                "GrubCustomizer" "GRUB configuration tool" "off")

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

# Main script
main() {
    selected_programing_items=$(display_checklist "Install and Configure Programming Items" "${programing_list[@]}")
    check_cancel
    selected_useful_items=$(display_checklist "Install and Configure Useful Items" "${useful_list[@]}")
    check_cancel

    all_selected_items=($selected_programing_items $selected_useful_items)

    clear
    echo "Installing and configuring the selected items..."
    echo "This may take a while..."
    echo ""

    # Create the log directory and file
    mkdir -p log
    touch log/install.log
    echo "" > log/install.log

    # Install the dependencies
    install_dep

    # Install the selected items
    install_packages "${all_selected_items[@]}"

    read -p "Installation Done! Press Enter to leave..." input
    exit 0
}

main