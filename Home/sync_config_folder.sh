#!/bin/bash

# --- Configuration ---
CONFIG_SOURCE_DIR="$HOME/.config/"
CONFIG_TARGET_DIR="$HOME/Desktop/M__projects/my-dotfiles/Home/.config"

BASHRC_FILE="$HOME/.bashrc"
BASHRC_TARGET_DIR="$HOME/Desktop/M__projects/my-dotfiles/Home/"

BASH_PROFILE_FILE="$HOME/.bash_profile"
BASH_PROFILE_FILE_TARGET_DIR="$HOME/Desktop/M__projects/my-dotfiles/Home/"

# --- Setup ---
echo "Ensuring target directory exists: $CONFIG_TARGET_DIR..."
mkdir -p "$CONFIG_TARGET_DIR" 
echo "-----------------------------------"


echo "1. Syncing contents of $CONFIG_SOURCE_DIR INTO $CONFIG_TARGET_DIR..."

# Use rsync for copying to leverage the '-u' (update) flag.
rsync -auv --progress "$CONFIG_SOURCE_DIR" "$CONFIG_TARGET_DIR"

if [ $? -ne 0 ]; then
    echo "❌ Rsync sync error for .config contents. Stopping script."
    exit 1
fi


echo "✅ .config contents sync complete. Original .config/ folder remains untouched."
echo "-----------------------------------"


echo "2. Copying $BASHRC_FILE to $BASHRC_TARGET_DIR using rsync..."

if [ -f "$BASHRC_FILE" ]; then
    rsync -auv "$BASHRC_FILE" "$BASHRC_TARGET_DIR"
    
    if [ $? -eq 0 ]; then
        echo "✅ Copy successful. A copy of .bashrc is now in your Git repository."
        echo "✅ The original file at ~/.bashrc remains in place."
    else
        echo "❌ Error copying $BASHRC_FILE."
    fi
else
    echo "⚠️ File not found: $BASHRC_FILE. Skipping copy."
fi


echo "3. Copying $BASH_PROFILE_FILE to $BASH_PROFILE_FILE_TARGET_DIR using rsync..."

if [ -f "$BASH_PROFILE_FILE" ]; then
    rsync -auv "$BASH_PROFILE_FILE" "$BASH_PROFILE_FILE_TARGET_DIR"
    
    if [ $? -eq 0 ]; then
        echo "✅ Copy successful. A copy of .bash_profile is now in your Git repository."
        echo "✅ The original file at ~/.bash_profile remains in place."
    else
        echo "❌ Error copying $BASH_PROFILE_FILE."
    fi
else
    echo "⚠️ File not found: $BASH_PROFILE_FILE. Skipping copy."
fi

echo "-----------------------------------"
echo "Script finished. Review your changes in your Git repository."