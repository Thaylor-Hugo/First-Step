#!/bin/bash

# Config the fish shell
# First argument is the flag for CMake
# Second argument is the flag for ROS2
# Third argument is the flag for STM32Cube
# Fourth argument is the flag for ARM-GCC
config_fish() {
    if [ $1 -eq 1 ]; then
        echo -e "function mkbuild\n    mkdir build\n    cd build\n    cmake..\nend \n"
        echo -e "function rmbuild\n    cd ..\n    rm -r build\nend \n"
    fi

    if [ $2 -eq 1 ]; then
        #TODO: install omf and bass
        echo -e "bass source /opt/ros/iron/setup.bash \n" >> ~/.config/fish/config.fish
    fi

    if [ $3 -eq 1 ]; then
        echo "set -gx CUBE_PATH /usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/" >> ~/.config/fish/config.fish
        echo "set PATH /usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin $PATH" >> ~/.config/fish/config.fish
        echo -e "\nfunction cubemx\n    \$CUBE_PATH/STM32CubeMX \$argv\nend \n" 
    fi

    if [ $4 -eq 1 ]; then
        echo "set PATH /usr/local/gcc-arm-none-eabi*/bin $PATH" >> ~/.config/fish/config.fish
    fi
}

# Install fish shell
# First argument is the flag for CMake
# Second argument is the flag for ROS2
# Third argument is the flag for STM32Cube
install_fish() {
    sudo apt-get install fish -y >> log/install.log
    sudo chsh -s $(which fish) >> log/install.log
    config_fish $1 $2 $3
    # yes | curl -L https://get.oh-my.fish | fish >> log/install.log
    # omf install bass >> log/install.log
}

