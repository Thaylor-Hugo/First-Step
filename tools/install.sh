#!/bin/bash

# Install packages
# First argument is the list of packages
install_packages() {
    local packages=("$@")
    apt-get update >> log/install.log
    apt-get upgrade -y >> log/install.log

    for package in "${packages[@]}"; do
        echo "Installing $package..."
        case $package in
            "Make")
                apt-get install make -y >> log/install.log ;;
            "CMake")
                apt-get install cmake -y >> log/install.log ;; 
            "VSCode")
                snap install --classic code >> log/install.log ;;
            "Discord")
                snap install discord >> log/install.log ;;
            "CopyQ") package_real_name="copyq"
                add-apt-repository ppa:hluk/copyq -y >> log/install.log
                apt-get update >> log/install.log
                apt-get install copyq -y >> log/install.log ;;
            "Baobab") 
                apt-get install baobab -y >> log/install.log ;;
        esac
        echo ""
    done
}
