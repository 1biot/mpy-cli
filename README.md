# Micropython Command line tools

Tools providing device connection, file operations and preparing development environment for your Micropython projects.

## Requirements
- [Python 3](https://www.python.org/downloads/)
- [Ampy](https://github.com/scientifichackers/ampy)
- [Mpremote](https://docs.micropython.org/en/latest/reference/mpremote.html)

## Installation

```commandline
git clone https://github.com/1biot/mpy-cli.git
cd mpy-cli
```

## Getting started
Tools are looking for file `.mpy.json`. This file is config for your project.
```
Getting_started
|-- src
|   |-- main.py
|-- tools
|   |-- mpy-cli
|   |   |-- connect.sh
|   |   |-- device.sh
|   |   |-- env.sh
|-- .mpy.json
```

Let's get started from project root
```commandline
cd Getting_started
```

### .mpy.json config file
```json
{
    "name": "Getting_started", // your project name
    "device": "esp32", // micropython porting device
    "micropython_version": "1.19.1", // micropython version
    "address": "/dev/tty.SLAB_USBtoUART", // device address
    "delay": 2, // delay for fixing bug with Ampy and MacOS
    "include": [
        "src"
    ]
}
```
### Micropython project environment
We need to initialize our project python environment.
```commandline
source ./tools/mpy-cli/env.sh init
```

### Connecting to the device
It is easy to connect to your device. Just type
```commandline
./tools/mpy-cli/connect.sh
```
```
Connected to MicroPython at /dev/tty.SLAB_USBtoUART
Use Ctrl-] to exit this shell
 8 2016 00:[aa][ba]j

rst:0x1 (POWERON_RESET),boot:0x13 (SPI_FAST_FLASH_BOOT)
configsip: 0, SPIWP:0xee
clk_drv:0x00,q_drv:0x00,d_drv:0x00,cs0_drv:0x00,hd_drv:0x00,wp_drv:0x00
mode:DIO, clock div:2
load:0x3fff0030,len:4540
ho 0 tail 12 room 4
load:0x40078000,len:12448
load:0x40080400,len:4124
entry 0x40080680 
MicroPython v1.19.1 on 2022-06-18; 4MB/OTA module with ESP32
Type "help()" for more information.
>>>
```
### Device file operations

`device.sh` is wrapper only using Ampy and provides all functionality of that module. See

```commandline
./tools/mpy-cli/device.sh --help
```

### Upload all
Upload all files and directories from `.mpy.json`

```commandline
./tools/mpy-cli/device.sh upload
```

### Upload single file

```commandline
./tools/mpy-cli/device.sh put src/main.py main.py
```

### Upload folder

```commandline
./tools/mpy-cli/device.sh put src/lib lib
```

### List files

```commandline
./tools/mpy-cli/device.sh ls
```

### List files at folder

```commandline
./tools/mpy-cli/device.sh ls lib
```

### Remove file

```commandline
./tools/mpy-cli/device.sh rm boot.py
```

### Remove folder

```commandline
./tools/mpy-cli/device.sh rmdir lib
```