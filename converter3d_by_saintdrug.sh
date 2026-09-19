#!/bin/bash

# Lock script context execution to its actual directory path placement location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Verify environment activation layer is available
if [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate
else
    echo -e "\033[1;31m[-] Error: Virtual environment missing. Please run ./setup.sh first.\033[0m"
    exit 1
fi

COLOR_TITLE="\033[1;35m"
COLOR_DESC="\033[0;36m"
COLOR_MENU="\033[1;34m"
COLOR_INPUT="\033[1;33m"
COLOR_SUCCESS="\033[1;32m"
COLOR_ERROR="\033[1;31m"
COLOR_RESET="\033[0m"

while true; do
    clear
    echo -e "${COLOR_TITLE}=================================================================${COLOR_RESET}"
    echo -e "${COLOR_TITLE}        2D to 3D Video Converter for VR (Written by SaintDruG)   ${COLOR_RESET}"
    echo -e "${COLOR_TITLE}=================================================================${COLOR_RESET}"
    echo -e "${COLOR_DESC}  Description: This tool uses monocular depth estimation AI to   ${COLOR_RESET}"
    echo -e "${COLOR_DESC}  extract depth values frame-by-frame and generate a Side-by-Side ${COLOR_RESET}"
    echo -e "${COLOR_DESC}  (SBS) flat 3D video perfect for viewing in VR movie players.  ${COLOR_RESET}"
    echo -e "${COLOR_TITLE}=================================================================${COLOR_RESET}"
    echo ""
    echo -e "${COLOR_MENU}  1) Convert 2D Video to 3D SBS${COLOR_RESET}"
    echo -e "${COLOR_MENU}  2) Exit Program${COLOR_RESET}"
    echo ""
    echo -e -n "${COLOR_INPUT}Select an option [1-2]: ${COLOR_RESET}"
    read -r MENU_CHOICE

    case $MENU_CHOICE in
        1)
            echo ""
            echo -e -n "${COLOR_INPUT}Please drag and drop your video file here and press Enter: ${COLOR_RESET}"
            read -r INPUT_PATH

            INPUT_PATH="${INPUT_PATH//\\/}"
            INPUT_PATH="${INPUT_PATH%\'}"
            INPUT_PATH="${INPUT_PATH#\'}"
            INPUT_PATH="${INPUT_PATH%\"}"
            INPUT_PATH="${INPUT_PATH#\"}"

            if [ ! -f "$INPUT_PATH" ]; then
                echo -e "${COLOR_ERROR}[-] Error: File not found. Path invalid.${COLOR_RESET}"
                echo ""
                echo "Press [Enter] to return to the menu..."
                read -r
                continue
            fi

            INPUT_DIR=$(dirname "$INPUT_PATH")
            FILENAME_NO_EXT=$(basename "$INPUT_PATH" | sed 's/\.[^.]*$//')

            CLEAN_INPUT="clean_processing_input.mp4"
            FINAL_OUTPUT="$INPUT_DIR/${FILENAME_NO_EXT}_3D_sbs.mp4"

            rm -f "$CLEAN_INPUT"
            rm -f "clean_processing_input_stereo_sbs.mp4"
            rm -f "clean_processing_input.mp4.sbs.mp4"

            echo ""
            echo -e "${COLOR_DESC}[+] Analyzing video audio streams...${COLOR_RESET}"

            HAS_APAC=$(ffmpeg -i "$INPUT_PATH" 2>&1 | grep -i "apac")

            if [ -n "$HAS_APAC" ]; then
                echo -e "${COLOR_INPUT}[!] Detected iPhone Spatial Audio. Isolating standard tracks...${COLOR_RESET}"
                ffmpeg -y -i "$INPUT_PATH" -map 0:0 -map 0:2 -c copy "$CLEAN_INPUT" -loglevel error
            else
                echo -e "${COLOR_DESC}[+] Normal video detected. Normalizing container layout...${COLOR_RESET}"
                ffmpeg -y -i "$INPUT_PATH" -map 0:v:0 -map 0:a? -c copy "$CLEAN_INPUT" -loglevel error
            fi

            if [ ! -f "$CLEAN_INPUT" ]; then
                echo -e "${COLOR_ERROR}[-] Error: FFmpeg pre-processing failed.${COLOR_RESET}"
                echo ""
                echo "Press [Enter] to return to the menu..."
                read -r
                continue
            fi

            echo -e "${COLOR_DESC}[+] Bypassing broken SciPy binary dependencies...${COLOR_RESET}"
            echo -e "${COLOR_SUCCESS}[+] Starting AI 3D Conversion...${COLOR_RESET}"
            echo -e "${COLOR_TITLE}----------------------------------------------------------------${COLOR_RESET}"

            # Run Python core strictly within memory-mocked isolation bounds
            python -s -c "import sys, types; sys.modules['scipy'] = types.ModuleType('scipy'); sys.modules['scipy.sparse'] = types.ModuleType('scipy.sparse'); import main; main.main()" "$CLEAN_INPUT" --strength 0.05 --eye-resolution 1920 1080

            echo -e "${COLOR_TITLE}----------------------------------------------------------------${COLOR_RESET}"

            if [ -f "clean_processing_input_stereo_sbs.mp4" ]; then
                mv "clean_processing_input_stereo_sbs.mp4" "$FINAL_OUTPUT"
            elif [ -f "clean_processing_input.mp4.sbs.mp4" ]; then
                mv "clean_processing_input.mp4.sbs.mp4" "$FINAL_OUTPUT"
            fi

            rm -f "$CLEAN_INPUT"

            if [ -f "$FINAL_OUTPUT" ]; then
                echo -e "${COLOR_SUCCESS}[+] SUCCESS! Your 3D video is ready next to your original file:${COLOR_RESET}"
                echo -e "${COLOR_SUCCESS}    $FINAL_OUTPUT${COLOR_RESET}"
            else
                echo -e "${COLOR_ERROR}[-] Error: Conversion failed or output file could not be verified.${COLOR_RESET}"
            fi
            
            echo ""
            echo "Press [Enter] to return to the main menu..."
            read -r
            ;;
        2)
            echo -e "${COLOR_INPUT}[+] Exiting tool. Goodbye!${COLOR_RESET}"
            exit 0
            ;;
        *)
            echo -e "${COLOR_ERROR}[-] Invalid option selection.${COLOR_RESET}"
            sleep 1.5
            ;;
    esac
done
