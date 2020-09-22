# #!/usr/bin/env bash

CYAN='\033[0;36m'
BOLD_GREEN="\033[1;32m"
RED="\e[0;31m"
BLUE="\e[0;34m"
RESET="\033[0m"

echo -e "${CYAN}"[+] "${RESET}""${BOLD_GREEN}"Creating directory to hold all Python virtual environments"${RESET}"
mkdir -p "${HOME}"/virtualenvs
echo -e "${CYAN}"[+] "${RESET}""${BOLD_GREEN}"Downloading setV"${RESET}"

curl -# https://raw.githubusercontent.com/kunnoh/python_env_setup/master/py_setup.sh | sh -

if [ -e "${HOME}/.bashrc"];
then
    echo -e "${CYAN}"[+] "${RESET}"Adding "${blue}"~/.bash_profile"${RESET}"
    echo "source ~/.py_setup.sh" >> ${HOME}/.bash_profile
fi
