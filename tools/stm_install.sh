#!/bin/bash

unzip_cube() {
    for cube_prog in stm/en.stm32cube*.zip; do
        unzip $cube_prog -d ${cube_prog%".zip"}
        rm -r $cube_prog
    done
}

install_cube_prog() {
    ./stm/en.stm32cubeprg*/SetupSTM32CubeProgrammer*.linux >> log/install.log
    apt-get install libusb-1.0-0-dev -y >> log/install.log
    cp /usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/*.* /etc/udev/rules.d
    echo "export PATH=$PATH:/usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin" >> ~/.bashrc
}

install_cube_mx() {
    ./stm/en.stm32cubemx*/SetupSTM32CubeMX* >> log/install.log
    echo "export CUBE_PATH=/usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/" >> ~/.bashrc
}

install_cube_mon() {
    echo "not supported yet"
}

install_cube() {
    unzip_cube
    install_cube_prog
    install_cube_mx
    install_cube_mon
}