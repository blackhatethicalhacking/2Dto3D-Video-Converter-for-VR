#!/bin/bash

# Define ANSI formatting colors for installation output logs
COLOR_INFO="\033[1;34m"
COLOR_SUCCESS="\033[1;32m"
COLOR_ERROR="\033[1;31m"
COLOR_RESET="\033[0m"

clear
echo -e "${COLOR_INFO}==================================================${COLOR_RESET}"
echo -e "${COLOR_INFO}    Initializing Standalone VR 3D Pipeline Setup  ${COLOR_RESET}"
echo -e "${COLOR_INFO}==================================================${COLOR_RESET}"

# 1. Verify or Install Homebrew Package Manager
if ! command -v brew &> /dev/null; then
    echo -e "${COLOR_INFO}[+] Homebrew not found. Installing system package manager...${COLOR_RESET}"
    /bin/bash -c "$(curl -fsSL https://githubusercontent.com)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "${COLOR_SUCCESS}[+] Homebrew dependency verified.${COLOR_RESET}"
fi

# 2. Verify or Install FFmpeg
if ! command -v ffmpeg &> /dev/null; then
    echo -e "${COLOR_INFO}[+] Installing FFmpeg multimedia processing engine via Homebrew...${COLOR_RESET}"
    brew install ffmpeg
else
    echo -e "${COLOR_SUCCESS}[+] FFmpeg multimedia engine verified.${COLOR_RESET}"
fi

# 3. Establish Isolated Python Virtual Environment
echo -e "${COLOR_INFO}[+] Creating clean python environment container (.venv)...${COLOR_RESET}"
python3 -m venv .venv
source .venv/bin/bin/activate 2>/dev/null || source .venv/bin/activate

# 4. Inject Verified Environment Packages
echo -e "${COLOR_INFO}[+] Upgrading internal environment deployment managers...${COLOR_RESET}"
pip install --upgrade pip setuptools wheel

echo -e "${COLOR_INFO}[+] Fetching pre-compiled math libraries and neural network structures...${COLOR_RESET}"
pip install -r requirements.txt --no-cache-dir

# 5. Lock Down Executable Verification Rules
chmod +x convert3d.sh

echo ""
echo -e "${COLOR_SUCCESS}==================================================${COLOR_RESET}"
echo -e "${COLOR_SUCCESS}  SETUP COMPLETE! Environment isolated successfully.${COLOR_RESET}"
echo -e "${COLOR_SUCCESS}  Launch your converter loop by running: ./convert3d.sh${COLOR_RESET}"
echo -e "${COLOR_SUCCESS}==================================================${COLOR_RESET}"
