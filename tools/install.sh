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

    for package in "${packages[@]}"; do
        echo -e "Installing $package... \n"
        case $package in
            "Make")
                sudo apt-get install make -y >> log/install.log ;;
            "CMake")
                sudo apt-get install cmake -y >> log/install.log ;; 
            "VSCode")
                sudo snap install --classic code >> log/install.log ;;
            "Discord")
                sudo snap install discord >> log/install.log ;;
            "CopyQ") package_real_name="copyq"
                sudo add-apt-repository ppa:hluk/copyq -y >> log/install.log
                sudo apt-get update >> log/install.log
                sudo apt-get install copyq -y >> log/install.log ;;
            "Baobab") 
                sudo apt-get install baobab -y >> log/install.log ;;
            "VLC")
                sudo apt-get install vlc -y >> log/install.log ;;
            "Git") 
                install_git ;;
            "ROS2")
                sudo install_ros >> log/install.log ;;
            "STM32Cube")
                install_cube ;;
            "JLink")
                sudo curl -fLO -d 'accept_license_agreement=accepted&submit=Download+software' https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
                sudo apt-get install ./JLink_Linux_x86_64.deb -y
                sudo rm JLink_Linux_x86_64.deb ;;
            "Fish")
                sudo install_fish ;;
        esac
    done
}
