function mkbuild
    mkdir build
    cd build
    cmake..
end 

function rmbuild
    cd ..
    rm -r build
end 

bass source /opt/ros/iron/setup.bash 

set -gx CUBE_PATH /usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/
set PATH /usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin $PATH

function cubemx
    $CUBE_PATH/STM32CubeMX $argv
end 

