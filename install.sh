#!/bin/bash

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

    echo -e ${YELLOW}"[*] ${GREEN}Operating System:${BOLD_GREEN}" ${OS_NAME} ${GREEN}"Version: "${BOLD_GREEN}${OS_VERSION}${RESET}
    echo -e ${YELLOW}"[*] ${GREEN}Path to virtual environment directory:${BOLD_GREEN}" ${PYSETENV_VIRTUAL_DIR_PATH}${RESET}
    echo -e ${YELLOW}"[*] ${GREEN}Python Version On Config.ini:${BOLD_GREEN}" ${PYSETENV_PYTHON_VERSION}${RESET}

    # Add Python on RedHat 7
    if [[ "$OS_NAME" == *"Red Hat"* ]];
    then
        # check if python is already installed
        if hash python${PYSETENV_PYTHON_VERSION};
        then
            echo -e ${YELLOW}"[*] ${CYAN}Checking python version installed currently on the system..."${RESET}
            echo -e ${YELLOW}"[*] " ${BOLD_GREEN}"$(python${PYSETENV_PYTHON_VERSION} -V) ${GREEN} already installed on the system"
        else
            read -p "install python${PYSETENV_PYTHON_VERSION} on the system (Y/N)" y_n
            case $y_n in
                Y|y)
                    subscription-manager repos --enable rhel-7-server-optional-rpms \
                    --enable rhel-server-rhscl-7-rpms
                    yum -y install @development
                    yum -y install rh-python36
                    yum -y install rh-python36-numpy \
                    rh-python36-scipy \ 
                    rh-python36-python-tools \
                    rh-python36-python-six
                    scl enable rh-python36 bash
                     ;;

                N|n)
                    echo -e ${YELLOW}"[!] ${RED}Aborting"${RESET}
                    exit 1;;

                *)
                    echo -e ${YELLOW}"[*] ${BOLD_YELLOW}Enter either Y|y for yes or N|n for no"
                    exit 1;;

            esac
        fi
    fi

    # Add Python on Debian
    if [[ "${OS_NAME}" == *"Debian"* ]] ;
    then
        add-apt-repository ppa:deadsnakes/ppa
        apt-get update
        apt-get install python${PYSETENV_PYTHON_VERSION}
        apt-get autoremove -y
    fi
    # Add Python PPA on Ubuntu
    if [[ "$OS_NAME" == *"Ubuntu"* ]];
    then     
        if hash python${PYSETENV_PYTHON_VERSION};
        then
            echo -e ${YELLOW}"[*] ${CYAN}Checking python version installed currently on the system..."${RESET}
            echo -e ${YELLOW}"[*] "${BOLD_GREEN}"$(python${PYSETENV_PYTHON_VERSION} -V) ${GREEN} already installed on the system"${RESET}
        
        else
            read -p "install python${PYSETENV_PYTHON_VERSION} on the system (Y/N)" y_n
            case $y_n in
                Y|y) 
                    add-apt-repository ppa:fkrull/deadsnakes
                    apt-get update
                    apt-get install python${PYSETENV_PYTHON_VERSION}
                    apt-get autoremove -y ;;
                N|n) 
                    echo -e ${YELLOW}"[!] ${RED}Aborting"${RESET}
                    exit 1;;
                *) 
                    echo -e ${YELLOW}"[*] ${BOLD_YELLOW}Enter either Y|y for yes or N|n for no"
                    exit 1;;
            esac
        fi
    fi
else
    # Add Python on CentOS
    if [  ];
    then
        echo Adding Python PPA
    fi
    echo -e ${YELLOW}"Exiting ! ! !"${RESET}
    exit 1
fi

if [ -f ~/.py_setup.sh ];
then
    echo -e ${YELLOW}"[*] "${BOLD_GREEN}"pysetenv already installed"
    echo -e ${YELLOW}"***********************************************************"${RESET}
    exit 1
fi

echo -e ${YELLOW}"[+] ${CYAN}Creating directory to hold all Python virtual environments"${RESET}
mkdir -p "${HOME}"/virtualenvs
echo -e ${YELLOW}"[*] ${CYAN}Downloading pysetenv"${PURPLE}

curl -# https://raw.githubusercontent.com/connessionetech/python-installer/master/py_setup.sh -o ${HOME}/.py_setup.sh
curl -# https://raw.githubusercontent.com/connessionetech/python-installer/master/config.ini -o ${HOME}/.config.ini

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
