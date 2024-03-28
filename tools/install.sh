#!/bin/bash

# Source the files
source_files=("tools/git_install.sh" "tools/ros_install.sh" "tools/stm_install.sh" "tools/fish_install.sh")
for file in "${source_files[@]}"; do
    source $file
done

# Install packages
# First argument is the list of packages
install_packages() {
    local packages=("$@")
    gum spin --spinner line --title "Updating system" -- sudo apt-get update >> log/install.log
    echo "System updated!"
    gum spin --spinner line --title "Upgrading system" -- sudo apt-get upgrade -y >> log/install.log
    echo -e "System upgraded! \n"
    
    # Flags for the fish shell
    cmake_on=0
    ros2_on=0
    stm32_on=0
    fish_on=0

    for package in "${packages[@]}"; do
        # What a shame I can't use the gum spin with custom functions here
        local title="Installing '$package'..."
        local gum_spin='gum spin --spinner line --title'
            case $package in
                "Make - Build tool")
                    $gum_spin "$title" -- sudo apt-get install make -y >> log/install.log ;;
                "CMake - Build system generator")
                    cmake_on=1
                    $gum_spin "$title" -- sudo apt-get install cmake -y >> log/install.log ;; 
                "VSCode - Feature-rich code editor")
                    $gum_spin "$title" -- sudo snap install --classic code >> log/install.log ;;
                "Discord - Communication platform")
                    $gum_spin "$title" -- sudo snap install discord >> log/install.log ;;
                "CopyQ - Clipboard manager")
                    $gum_spin "$title" -- sudo add-apt-repository ppa:hluk/copyq -y >> log/install.log
                    $gum_spin "$title" -- sudo apt-get update >> log/install.log
                    $gum_spin "$title" -- sudo apt-get install copyq -y >> log/install.log ;;
                "Baobab - Disk usage analiser") 
                    $gum_spin "$title" -- sudo apt-get install baobab -y >> log/install.log ;;
                "VLC - Media player")
                    $gum_spin "$title" -- sudo apt-get install vlc -y >> log/install.log ;;
                "Git - Version control system") 
                    install_git ;;
                "ROS2 - Robotics framework")
                    ros2_on=1
                    install_ros ;;
                "STM32Cube - CubeProgrammer, CubeMX and CubeMonitor")
                    stm32_on=1
                    install_cube ;;
                "ARM-GCC - Compiler for ARM processors") 
                    $gum_spin "$title" -- sudo apt-get install gcc-arm-none-eabi -y >> log/install.log ;;
                "JLink - JLink tools")
                    $gum_spin "$title" -- sudo curl -fLO -d 'accept_license_agreement=accepted&submit=Download+software' https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
                    $gum_spin "$title" -- sudo dpkg -i ./JLink_Linux_x86_64.deb >> log/install.log
                    $gum_spin "$title" -- sudo rm JLink_Linux_x86_64.deb ;;
                "Fish - Interactive shell")
                    fish_on=1 ;;
                "GCC - GNU Compiler Collection")
                    $gum_spin "$title" -- sudo apt-get install gcc -y >> log/install.log ;;
                "Charge Rules - Auto change power profile")
                    $gum_spin "$title" -- sudo mv rules/* /etc/udev/rules.d/ 
                    $gum_spin "$title" -- sudo udevadm control --reload-rules
                    $gum_spin "$title" -- sudo udevadm trigger ;;
            esac
        echo -e "$package installed! \n" 
    done
    source ~/.bashrc
    if [ $fish_on -eq 1 ]; then
        install_fish $cmake_on $ros2_on $stm32_on
        source ~/.config/fish/config.fish
    fi
}
