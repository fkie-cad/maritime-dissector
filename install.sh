#!/bin/sh
# This script installs the maritime-dissector plugin.
# It copies all .lua files to the personal plugin directory of the 
# currently active user.
# The directory will be created if it does not exist already.
# Wireshark has to be installed to use the plugin after this installation.
# The installation will not work if wireshark is not installed.
# Do not run this installation script as root user.

# fail on error
set -eu

# check if script is executed as root which it should NOT
if [ $(id -u) = 0 ]; then
    echo "FAILED: Installation script was executed as root."
    echo "Try again and do NOT run this script as root."
    echo
    echo "Exiting installation"
fi

echo "Run initial checks before installation..."
echo

# Check if wireshark is installed and exit if not.
echo "Check if wireshark is installed..."
if [ ! $(command -v wireshark) ] && [ ! $(command -v tshark) ]; then
    echo "WARNING: Both wireshark and tshark command could not be found."
    echo "         Probably neither wireshark nor tshark is installed."
    echo "         To use this plugin either wireshark or tshark are required."
    echo
    echo -n "Continue anyways (y/n)? "
    old_stty_cfg=$(stty -g)
    stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg
    if echo "$answer" | grep -iq "^y" ;then
        echo Yes
        echo
    else
        echo No
        echo
        echo "Exiting installation."
        exit 1
    fi
else
    if [ $(command -v wireshark) ]; then
        echo "Success: Wireshark found. Continuing..."
        echo
    else
        echo "Success: Tshark found. Continuing..."
        echo
    fi
fi

# Check if the users private wireshark plugin directory exists
WIRESHARK_PLUGIN_PATH=$HOME/.local/lib/wireshark/plugins/
echo "The dissector will be installed in current users private wireshark plugin directory:"
echo $WIRESHARK_PLUGIN_PATH
echo
echo "Check if plugin directory exists..."
if [ -d "$WIRESHARK_PLUGIN_PATH" ]; then
    if [ -L "$WIRESHARK_PLUGIN_PATH" ]; then
        # It is a symlink! Let the user solve the problem...
        echo "FAILED: $WIRESHARK_PLUGIN_PATH is a symlink."
        echo "Please remove the symlink and try again."
        echo
        echo "Exiting installation."
        exit 1
    else
        # It's a directory! continue the installation
        echo "Success: $WIRESHARK_PLUGIN_PATH is a directory. Continuing..."
        echo
    fi
else
    # Directory could not be found!
    echo "WARNING: $WIRESHARK_PLUGIN_PATH could not be found"
    echo
    # Ask the user if the directory should be created
    echo -n "Continue by creating the directory (y/n)? "
    old_stty_cfg=$(stty -g)
    stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg
    if echo "$answer" | grep -iq "^y" ;then
        # Yes: Create the directory and continue
        echo Yes
        echo
        echo "Creating directory: $WIRESHARK_PLUGIN_PATH"
        mkdir -p $WIRESHARK_PLUGIN_PATH
    else
        # No: Exit the installation
        echo No
        echo
        echo "Exiting installation."
        exit 1
    fi
fi

echo "Initial checks successfull. Starting installation..."
echo

# Do the installtion by copying the files to the plugin
echo "Copy files to plugin directory..."
( set -x; cp -r ./maritime-modules $WIRESHARK_PLUGIN_PATH )
( set -x; cp -r ./br24-modules $WIRESHARK_PLUGIN_PATH )
( set -x; cp -r ./furuno-modules $WIRESHARK_PLUGIN_PATH )
( set -x; cp ./maritime-dissector.lua $WIRESHARK_PLUGIN_PATH )
( set -x; cp ./br24-dissector.lua $WIRESHARK_PLUGIN_PATH )
( set -x; cp ./furuno-dissector.lua $WIRESHARK_PLUGIN_PATH )
echo
echo "Installation successfull. Exiting."
exit 0
