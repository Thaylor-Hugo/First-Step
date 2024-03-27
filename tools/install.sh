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
        echo -e "Installing $package... \n"
        case $package in
            "Make - Build tool")
                sudo apt-get install make -y >> log/install.log ;;
            "CMake - Build system generator")
                cmake_on=1
                sudo apt-get install cmake -y >> log/install.log ;; 
            "VSCode - Feature-rich code editor")
                sudo snap install --classic code >> log/install.log ;;
            "Discord - Communication platform")
                sudo snap install discord >> log/install.log ;;
            "CopyQ - Clipboard manager")
                sudo add-apt-repository ppa:hluk/copyq -y >> log/install.log
                sudo apt-get update >> log/install.log
                sudo apt-get install copyq -y >> log/install.log ;;
            "Baobab - Disk usage analiser") 
                sudo apt-get install baobab -y >> log/install.log ;;
            "VLC - Media player")
                sudo apt-get install vlc -y >> log/install.log ;;
            "Git - Version control system") 
                install_git ;;
            "ROS2 - Robotics framework")
                ros2_on=1
                install_ros ;;
            "STM32Cube - CubeProgrammer, CubeMX and CubeMonitor")
                stm32_on=1
                install_cube ;;
            "ARM-GCC - Compiler for ARM processors") 
                sudo apt-get install gcc-arm-none-eabi -y >> log/install.log ;;
            "JLink - JLink tools")
                sudo curl -fLO -d 'accept_license_agreement=accepted&submit=Download+software' https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
                sudo dpkg -i ./JLink_Linux_x86_64.deb >> log/install.log
                sudo rm JLink_Linux_x86_64.deb ;;
            "Fish - Interactive shell")
                fish_on=1 ;;
            "GCC - GNU Compiler Collection")
                sudo apt-get install gcc -y >> log/install.log ;;
            "Charge Rules - Auto change power profile")
                sudo mv rules/* /etc/udev/rules.d/ 
                sudo udevadm control --reload-rules && sudo udevadm trigger ;;
        esac
    done
    source ~/.bashrc
    if [ $fish_on -eq 1 ]; then
        install_fish $cmake_on $ros2_on $stm32_on
        source ~/.config/fish/config.fish
    fi
}
