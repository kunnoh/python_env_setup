# #!/usr/bin/env bash

CYAN='\033[0;36m'
BOLD_GREEN="\033[1;32m"
RED="\e[0;31m"
BLUE="\e[0;34m"
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET="\033[0m"

echo -e "${BOLD_GREEN}"[+] "${RESET}""${CYAN}"Creating directory to hold all Python virtual environments"${RESET}"
mkdir -p "${HOME}"/virtualenvs
echo -e "${YELLOW}"[*] "${RESET}""${CYAN}"Downloading pysetenv"${BLUE}${PURPLE}"

curl -# https://raw.githubusercontent.com/kunnoh/python_env_setup/master/py_setup.sh -o ${HOME}/.py_setup.sh

if [ -e "${HOME}/.bashrc" ];
then
    echo -e "${BOLD_GREEN}"[+] "${CYAN}"Adding "${GREEN}"~/.bash_profile"${RESET}"
    echo "source ~/.py_setup.sh" >> ${HOME}/.bashrc
elif [ -e "${HOME}/.bash_profile" ];
then
    echo -e "${BOLD_GREEN}"[+] "${CYAN}"Adding "${GREEN}"~/.bash_profile"${RESET}"
    echo "source ~/.py_setup.sh" >> ${HOME}/.bash_profile
fi

# Installation complete
echo -e "${YELLOW}"[*] "${CYAN}"Installation Completed Successfully!
echo -e "${YELLOW}"[*] "${CYAN}"Type: "${BLUE}" 'source ~/.bashrc'
echo -e "${YELLOW}"[*] "${CYAN}"Or open new terminal and start using "${BOLD_GREEN}"pysetenv

# Usage
echo -e "${YELLOW}"#############################
echo -e "${GREEN}"Usage: pysetenv "${BOLD_GREEN}"VIRTUAL_ENVIRONMENT_NAME"${RESET}"\n