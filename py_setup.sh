# #!/usr/bin/env bash

CYAN='\033[0;36m'
BOLD_GREEN="\033[1;32m"
RED="\e[0;31m"
BLUE="\e[0;34m"
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD_YELLOW='\033[1;33m'
RESET="\033[0m"

# Path to virtual environment directory
PYSETENV_VIRTUAL_DIR_PATH="$HOME/virtualenvs/"

#  Default python version to use
PYSETENV_PYTHON_VERSION=3
PYSETENV_PYTHON_PATH=$(which python${PYSETENV_PYTHON_VERSION})

function _pysetenv_help()
{
    # Echo usage message
    echo -e "${YELLOW}"Usage: pysetenv [OPTIONS] [NAME]
    echo -e "${BOLD_YELLOW}"EXAMPLE:
    echo -e "${BOLD_GREEN}"pysetenv -n foo       "${CYAN}"Create virtual environment with name foo
    echo -e "${BOLD_GREEN}"pysetenv foo          "${CYAN}"Activate foo virtual env.
    echo -e "${BOLD_YELLOW}"Optional Arguments:"${BLUE}"
    echo -l, --list                  List all virtual environments.
    echo -n, --new NAME              Create a new Python Virtual Environment.
    echo -d, --delete NAME           Delete existing Python Virtual Environment.
    echo -e -p, --python PATH        Python binary path."${RESET}"
    echo -e "${BOLD_YELLOW}"Load existing project:
    echo -e "${BLUE}"-l, "--load /path/to/project -e|--environment NAME Load existing project to""${RESET}"
}

# Creates new virtual environment if ran with -n | --new flag
function _pysetenv_create()
{
    if [ -z ${1} ];
    then
        echo -e "${RED}"[!] ERROR!! Please pass virtual environment name!
        _pysetenv_help
    else
        echo -e "${BOLD_GREEN}"[+] "${GREEN}"Adding new virtual environment: $1"${RESET}"

        if [ ${PYSETENV_PYTHON_VERSION} -eq 3 ];
        then
            ${PYSETENV_PYTHON_PATH} -m venv ${PYSETENV_VIRTUAL_DIR_PATH}${1}
        else
            virtualenv -p ${PYSETENV_PYTHON_PATH}${PYSETENV_VIRTUAL_DIR_PATH}${1}
        fi

        echo -e "${CYAN}"[*] Activate python virtual environment using this command: pysetenv ${1}"${RESET}"
    fi
}


 # Deletes existing virtual environment if ran with -d|--delete flag
function _pysetenv_delete()
{
    if [ -z ${1} ];
    then
        echo -e "${RED}"[!] ERROR!! Please pass virtual environment name!
        _pysetenv_help
    else
        if [ -d ${PYSETENV_VIRTUAL_DIR_PATH}${1} ];
        then
            read -p "[?] Confirm you want to delete ${1} virtual environment (Y/N)" yes_no
            case $yes_no in
                Y|y) rm -rvf ${PYSETENV_VIRTUAL_DIR_PATH}${1};;
                N|n) echo "[*] Aborting environment deletion";;
                *) echo "[*] enter either Y/y for yes or N/n"
            esac
        else
            echo "${RED}"[!] ERROR!! No virtual environment exists byt he name: ${1}"${RESET}"
        fi
    fi
}


# Lists all virtual environments if ran with -l|--list flag
function _pysetenv_list()
{
    echo -e "${BOLD_YELLOW}"[*] "${CYAN}"List of virtual environments you have under ${PYSETENV_VIRTUAL_DIR_PATH}"${BLUE}"
    for v in $(ls -l ${PYSETENV_VIRTUAL_DIR_PATH} | egrep '^d' | awk -F " " '{print $NF}' )
    do
        echo -e ${BOLD_YELLOW} ${v} ${RESET}
    done
}


# Main function
function pysetenv()
{
    if [ $# -eq 0 ]; # If no argument show help
    then
        _pysetenv_help
    elif [ $# -le 3 ];
    then
        case "${1}" in
            -n|--new) _pysetenv_create ${2};;
            -d|--delete) _pysetenv_delete ${2};;
            -l|--list) _pysetenv_list;;
            *) if [ -d ${PYSETENV_VIRTUAL_DIR_PATH}${1} ];
               then
                   source ${PYSET_VIRTUAL_DIR_PATH}${1}/bin/activate
                else
                    echo -e "${RED}"[!] ERROR!! virtual environment with name ${1} does not exist
                    _pysetenv_help
                fi
                ;;
        esac
    fi
}