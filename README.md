> THIS IS EXPERIMENTAL AND SUBJECT OF CHANGE

# Micropython Command line tools

Tools providing device connection, file operations and preparing development environment for your Micropython projects.
You can use this tool for creating environment for your favorite IDE (Pycharm, Visual Studio Code).

## Requirements
- [Python 3](https://www.python.org/downloads/)
- [Ampy](https://github.com/scientifichackers/ampy)
- [Mpremote](https://docs.micropython.org/en/latest/reference/mpremote.html)

## Installation

```commandline
git clone https://github.com/1biot/mpy-cli.git
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
    "env_path": ".venv", // you can choose path where mpy-cli install environment
    "include_dir": "src" // your project dir
}
```
### Using mpy-cli
```commandline
PATH=$PATH:$PWD/tools/mpy-cli
```

Now you can use mpy-cli. You need call this line again when you start new promt,
but you set `PATH` variable to you `.bashrc` or `.zshrc` file

### Micropython project environment
We need to initialize our project python environment. This command installs right stubs for your board. I tried only esp32, but I will test more boards.
```commandline
source mpy-cli env init
```

### Connecting to the device
It is easy to connect to your device. Just type
```commandline
mpy-cli connect
```
```
Connected to MicroPython at /dev/tty.SLAB_USBtoUART
Use Ctrl-] to exit this shell
 
MicroPython v1.19.1 on 2022-06-18; 4MB/OTA module with ESP32
Type "help()" for more information.
>>>
```
### Device file operations

`device.sh` is wrapper only using Ampy and provides all functionality of that module. See

```commandline
mpy-cli device --help
```

### Upload all
Upload all files and directories from `.mpy.json`

```commandline
mpy-cli device upload-all
```

### Upload single file

```commandline
mpy-cli device put src/main.py main.py
```

### Upload folder

```commandline
mpy-cli device put src/lib lib
```

### List files

```commandline
mpy-cli device ls
```

### List files at folder

```commandline
mpy-cli device ls lib
```

### Remove file

```commandline
mpy-cli device rm boot.py
```

### Remove folder

```commandline
mpy-cli device rmdir lib
```

## What will be
- [ ] guide script for initializing .mpy.json file
- [ ] flashing micropython to the boards
- [ ] uploading all includes files by one command
- [ ] test more boards
- [x] unify and pack to `mpy-cli` command and uses as like `mpy-cli connect` or `mpy-cli device ls`
- [ ] installing `mpy-cli` to the `PATH` variable 
- [ ] help and documentation