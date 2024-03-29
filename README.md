# First-Step
First step of a new operating system. Scripts for configuring the system in new installs

## Dependencies
The script has some dependencies that are automatically installed. They are:
* [Gum](https://github.com/charmbracelet/gum) - A tool for glamorous shell scripts
* [Curl](https://curl.se/) - Command-line tool for transferring data with URL syntax
* [XClip](https://github.com/astrand/xclip) - Command line interface to X selections (clipboard)
* [Unzip]() - List, test and extract compressed files in a ZIP archive

## Things You Can Install

### Programming Packages

* [Git](https://git-scm.com/) - Version control system
* [Fish](https://fishshell.com/) - Interactive shell
* [GCC](https://gcc.gnu.org/) - GNU Compiler Collection
* [Make](https://www.gnu.org/software/make/) - Build tool
* [CMake](https://cmake.org/) - Build system generator
* [VSCode](https://code.visualstudio.com/) - Feature-rich code editor
* [ROS2](https://docs.ros.org/en/iron/index.html) - Robotics framework
* [JLink](https://www.segger.com/downloads/jlink/) - JLink tool
* [STM32Cube programs](https://www.st.com/en/development-tools/stm32-software-development-tools.html) - CubeProgrammer, CubeMX and CubeMonitor 
* [ARM-GCC](https://developer.arm.com/Tools%20and%20Software/GNU%20Toolchain) - Compiler for ARM processors

### Useful Packages
* [Discord](https://discord.com/) - Communication platform
* [VLC](https://www.videolan.org/vlc/index.pt_BR.html) - Media player
* [CopyQ](https://hluk.github.io/CopyQ/) - Clipboard manager
* [Baobab](https://wiki.gnome.org/action/show/Apps/DiskUsageAnalyzer?action=show&redirect=Apps%2FBaobab) - Disk usage analyzer
* Charge Rules - Auto change power based on charging status 
    
### Gnome Extensions
* [Battery Health Charging](https://extensions.gnome.org/extension/5724/battery-health-charging/) - Battery health and charging information
* [Blur My Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/) - Blur the shell background and lock screen
* [Caffeine](https://extensions.gnome.org/extension/517/caffeine/) - Prevent the activation of the screensaver
* [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/) - Clipboard manager
* [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/) - Move the dash out of the overview transforming it in a dock
* [Extension List](https://extensions.gnome.org/extension/3088/extension-list/) - Manage GNOME Shell extensions
* [GNOME 40 UI Improvements](https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/) - GNOME 40 UI Improvements
* [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/) - KDE Connect implementation for GNOME
* [Impatience](https://extensions.gnome.org/extension/277/impatience/) - Speed up the GNOME Shell animations
* [Net Speed Simplified](https://extensions.gnome.org/extension/3724/net-speed-simplified/) - Display the network speed
* [Order Gnome Shell Extensions](https://extensions.gnome.org/extension/2114/order-gnome-shell-extensions/) - Order Gnome Shell Extensions
* [Refresh WiFi Connections](https://extensions.gnome.org/extension/905/refresh-wifi-connections/) - Refresh WiFi Connections
* [Sound Output Device Chooser](https://extensions.gnome.org/extension/906/sound-output-device-chooser/) - Sound Output Device Chooser
* [User Themes](https://extensions.gnome.org/extension/19/user-themes/) - User Themes
* [Vitals](https://extensions.gnome.org/extension/1460/vitals/) - System monitoring
* [WinTile](https://extensions.gnome.org/extension/1723/wintile-windows-10-window-tiling-for-gnome/) - Windows 10 window tiling for GNOME

## STM32Cube Dependencies
Please download the STM softwares (CubeMX, CubeProgrammer and CubeMonitor) and place them on stm folder. For more information read [stm README](stm/README.md)

## How to Use
Just run the top level script "first_step.sh" on the project root directory
```bash
./first_step.sh
```