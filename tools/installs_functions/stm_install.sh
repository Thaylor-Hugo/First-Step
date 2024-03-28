#!/bin/bash

unzip_cube() {
    for cube_prog in stm/en.stm32cube*.zip; do
        $gum_spin "$title" -- unzip $cube_prog -d ${cube_prog%".zip"}
        sudo rm -rf $cube_prog
    done
}

install_cube_prog() {
    local title="Installing 'STM32CubeProgrammer'..."
    $gum_spin "$title" -- sudo ./stm/en.stm32cubeprg*/SetupSTM32CubeProgrammer*.linux >> log/install.log
    $gum_spin "$title" -- sudo apt-get install libusb-1.0-0-dev -y >> log/install.log
    $gum_spin "$title" -- sudo cp /usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/rules/*.* /etc/udev/rules.d
    echo "export PATH=\$PATH:/usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin" >> ~/.bashrc
    sudo rm -rf ./stm/en.stm32cubeprg*
}

install_cube_mx() {
    local title="Installing 'STM32CubeMX'..."
    $gum_spin "$title" -- sudo ./stm/en.stm32cubemx*/SetupSTM32CubeMX* >> log/install.log
    echo "export CUBE_PATH=/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/" >> ~/.bashrc
    echo -e "cubemx() {\n    \$CUBE_PATH/STM32CubeMX \$1 &> /dev/null &\n}" >> ~/.bashrc
    sudo rm -rf ./stm/en.stm32cubemx*
}

install_cube_mon() {
    local title="Installing 'STM32Monitor'..."
    echo "CubeMonitor not supported yet"
}

install_cube() {
    local title="Installing 'STM32Cube - CubeProgrammer, CubeMX and CubeMonitor'..."
    local gum_spin='gum spin --spinner line --title'
    unzip_cube
    install_cube_prog
    install_cube_mx
    install_cube_mon
    source ~/.bashrc
}