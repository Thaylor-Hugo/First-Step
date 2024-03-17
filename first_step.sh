#!/bin/bash

# Check if the user is root
if [ `whoami` != 'root' ]; then
    echo "Root privileges are required for this operation. Please re-run with sudo command."
    exit 1
fi

# Define the checklist items
programing_list=(   "Git" "Version control system" "off" \
                    "Fish" "Interactive shell" "off" \
                    "Make" "Build tool" "off" \
                    "CMake" "Build system generator" "off" \
                    "VSCode" "Feature-rich code editor" "off" \
                    "ROS2" "Robotics framework" "off" \
                    "STM32Cube" "CubeProgrammer, CubeMX and CubeMonitor" "off")

useful_list=(   "Discord" "Communication platform" "off" \
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
while true; do
    
    selected_programing_items=$(display_checklist "Install and Configure Programming Items" "${programing_list[@]}")
    check_cancel
    selected_useful_items=$(display_checklist "Install and Configure Useful Items" "${useful_list[@]}")
    check_cancel

    clear
    echo "Selected items:"
    for item in $selected_programing_items; do
        echo "$item"
    done
    for item in $selected_useful_items; do
        echo "$item"
    done

    read -p "Press Enter to continue..." input
done
