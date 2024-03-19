#!/bin/bash

unzip_cube() {
    for cube_prog in stm/en.stm32cube*.zip; do
        unzip $cube_prog -d ${cube_prog%".zip"}
        rm -r $cube_prog
    done
}

install_cube_prog() {
    sudo ./stm/en.stm32cubeprg*/SetupSTM32CubeProgrammer*.linux >> log/install.log
    sudo apt-get install libusb-1.0-0-dev -y >> log/install.log
    sudo cp /usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/rules/*.* /etc/udev/rules.d
    echo "export PATH=\$PATH:/usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin" >> ~/.bashrc
}

install_cube_mx() {
    sudo ./stm/en.stm32cubemx*/SetupSTM32CubeMX* >> log/install.log
    echo "export CUBE_PATH=/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/" >> ~/.bashrc
    echo -e "cubemx() {\n    \$CUBE_PATH/STM32CubeMX \$1\n}" >> ~/.bashrc
}

install_cube_mon() {
    echo "CubeMonitor not supported yet"
}

install_cube() {
    unzip_cube
    install_cube_prog
    install_cube_mx
    install_cube_mon
    source ~/.bashrc
}