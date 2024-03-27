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
    sudo apt-get update >> log/install.log
    sudo apt-get upgrade -y >> log/install.log
    
    # Flags for the fish shell
    cmake_on=0
    ros2_on=0
    stm32_on=0
    fish_on=0

    for package in "${packages[@]}"; do
        local GUM_SPIN='gum spin --spinner line --title "Installing $package..." -- '
            case $package in
                "Make - Build tool")
                    $GUM_SPIN sudo apt-get install make -y >> log/install.log ;;
                "CMake - Build system generator")
                    cmake_on=1
                    $GUM_SPIN sudo apt-get install cmake -y >> log/install.log ;; 
                "VSCode - Feature-rich code editor")
                    $GUM_SPIN sudo snap install --classic code >> log/install.log ;;
                "Discord - Communication platform")
                    $GUM_SPIN sudo snap install discord >> log/install.log ;;
                "CopyQ - Clipboard manager")
                    $GUM_SPIN sudo add-apt-repository ppa:hluk/copyq -y >> log/install.log
                    $GUM_SPIN sudo apt-get update >> log/install.log
                    $GUM_SPIN sudo apt-get install copyq -y >> log/install.log ;;
                "Baobab - Disk usage analiser") 
                    $GUM_SPIN sudo apt-get install baobab -y >> log/install.log ;;
                "VLC - Media player")
                    $GUM_SPIN sudo apt-get install vlc -y >> log/install.log ;;
                "Git - Version control system") 
                    install_git ;;
                "ROS2 - Robotics framework")
                    ros2_on=1
                    install_ros ;;
                "STM32Cube - CubeProgrammer, CubeMX and CubeMonitor")
                    stm32_on=1
                    install_cube ;;
                "ARM-GCC - Compiler for ARM processors") 
                    $GUM_SPIN sudo apt-get install gcc-arm-none-eabi -y >> log/install.log ;;
                "JLink - JLink tools")
                    $GUM_SPIN sudo curl -fLO -d 'accept_license_agreement=accepted&submit=Download+software' https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
                    $GUM_SPIN sudo dpkg -i ./JLink_Linux_x86_64.deb >> log/install.log
                    $GUM_SPIN sudo rm JLink_Linux_x86_64.deb ;;
                "Fish - Interactive shell")
                    fish_on=1 ;;
                "GCC - GNU Compiler Collection")
                    $GUM_SPIN sudo apt-get install gcc -y >> log/install.log ;;
                "Charge Rules - Auto change power profile")
                    $GUM_SPIN sudo mv rules/* /etc/udev/rules.d/ 
                    $GUM_SPIN sudo udevadm control --reload-rules
                    $GUM_SPIN sudo udevadm trigger ;;
            esac
        echo -e "$package installed! \n" 
    done
    source ~/.bashrc
    if [ $fish_on -eq 1 ]; then
        install_fish $cmake_on $ros2_on $stm32_on
        source ~/.config/fish/config.fish
    fi
}
