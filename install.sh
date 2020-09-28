# #!/bin/bash

CYAN='\033[0;36m'
BOLD_GREEN="\033[1;32m"
RED="\e[0;31m"
BOLD_RED='\033[1;31m'
BLUE="\e[0;34m"
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD_YELLOW='\033[1;33m'
RESET="\033[0m"

echo ""
echo ""
echo -e ${YELLOW}"***********************************************************"${RESET}

# Load config.ini file
. ./config.ini

if [ -f /etc/os-release ];
then
    # Get Os details
    OS_NAME=$(cat /etc/os-release | grep -w NAME | cut -d= -f2 | tr -d '"')
    OS_VERSION=$(cat /etc/os-release | grep -w VERSION_ID | cut -d= -f2 | tr -d '"')
    DISTRO=$(cat /etc/os-release | grep -w ID_LIKE | cut -d= -f2 | tr -d '=')

    echo -e ${YELLOW}"[*] ${GREEN}Found:${BOLD_GREEN}" ${OS_NAME} ${GREEN}"Version: "${BOLD_GREEN}${OS_VERSION}
    
    # Add Python on RedHat 7
    if [  ];
    then
        echo Adding Python PPA
    fi

    # Add Python on Debian
    if [[ ${OS_NAME} == *Kali* ]] ;
    then
        add-apt-repository ppa:deadsnakes/ppa
        apt-get update
        apt-get install python${PYSETENV_PYTHON_VERSION}
    fi

    # Add Python PPA on Ubuntu
    if [[ ${OS_NAME} == *Ubuntu* ]];
    then
        add-apt-repository ppa:fkrull/deadsnakes
        apt-get update
        apt-get install python${PYSETENV_PYTHON_VERSION}
        exit
    fi
else
    # Add Python on CentOS
    if [  ];
    then
        echo Adding Python PPA
    fi
    echo -e ${BOLD_RED}"THIS IS NOT A GNU/LINUX DISTRO"
    echo -e ${YELLOW}"Exiting ! ! !"${RESET}
    exit 1
fi

echo -e ${YELLOW}"[*] ${CYAN}Checking python version installed currently on the system..."${RESET}

_install_py()
{
    if hash python${PYSETENV_PYTHON_VERSION};
    then
        echo -e ${YELLOW}"[*]${BOLD_GREEN}" $(python${PYSETENV_PYTHON_VERSION} -V) ${CYAN}"Found on the system"

    else
        echo -e ${YELLOW}"[!] Warning! ${CYAN} python${PYSETENV_PYTHON_VERSION} not found on the system..."
        read -p "[+] Install Python${PYSETENV_PYTHON_VERSION} on the system... (Y/N)" yes_no
        exit 1

    fi
}

ver=$(python3 -V 2>&1 | sed 's/.* \([0-9]\).\([0-9]\).*/\1\2/')

if [ "$ver" -lt "35" ];
then
    echo -e ${BOLD_RED}"[!] ${RED}python3 not found"
    echo -e ${BOLD_GREEN}"[+] ${CYAN}Installing python3"
fi

echo -e ${BOLD_GREEN}"[+] ${CYAN}Creating directory to hold all Python virtual environments"${RESET}
mkdir -p "${HOME}"/virtualenvs
echo -e ${YELLOW}"[*] ${CYAN}Downloading pysetenv"${PURPLE}

curl -# https://raw.githubusercontent.com/connessionetech/python-installer/master/py_setup.sh -o ${HOME}/.py_setup.sh

if [ -e "${HOME}/.zshrc" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.zshrc"${RESET}
    echo "source ~/.py_setup.sh" >> ${HOME}/.zshrc

elif [ -e "${HOME}/.bashrc" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.bash_profile"${RESET}
    echo -e "source ~/.py_setup.sh" >> ${HOME}/.bashrc

elif [ -e "${HOME}/.bash_profile" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.bash_profile"${RESET}
    echo -e "source ~/.py_setup.sh" >> ${HOME}/.bash_profile
fi

# Installation complete
echo -e ${YELLOW}"[*] ${CYAN}Installation Completed Successfully!"

# Usage Info
echo -e ${GREEN} "Type: ${BOLD_GREEN}source ~/.bashrc ${CYAN}to activate pysetenv or open a new terminal and start using pysetenv"
echo -e ${GREEN} "Usage: ${BOLD_GREEN}pysetenv --new VIRTUAL_ENVIRONMENT_NAME ${CYAN}to create new virtual environment"
echo -e ${GREEN} "Usage: ${BOLD_GREEN}pysetenv VIRTUAL_ENVIRONMENT_NAME ${CYAN}to activate the new virtual environment"
echo -e ${YELLOW}"***********************************************************"${RESET}
echo ""
echo ""