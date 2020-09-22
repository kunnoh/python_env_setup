
# Path to virtual environment directory
PYSETENV_DIR_PATH="$HOME/virtualenvs/"

#  Default python version to use
PYSETENV_PYTHON_VERSION=3
PYSETENV_PYTHON_PATH="$(which python${PYSETENV_PYTHON_VERSION})"

function _pysetenv_help_()
{
    # Echo usage message
    echo "Usage: pysetenv [OPTIONS] [NAME]"
    echo :
    echo "NAME                  Activate virtual env."
    echo Optional Arguments:
    echo "-l, --list            List all virtual environments."
    echo "-n, --new NAME        Create a new Python Virtual Environment."
    echo "-d, --delete NAME     Delete existing Python Virtual Environment."
    echo "-p, --python PATH     Python binary path."
}

function _pysetenv_custom_python_path()
{
    if [ -f "${1}" ];
    then
        if [ "`expr $1 : '.*python\([2,3]\)'`" = "3" ];
        then
            PYSETENV_PYTHON_VERSION=3
        else
            PYSETENV_PYTHON_VERSION=2
        fi
        PYSETENV_PYTHON_PATH=${1}
        _pysetenv_create $2
    else
        echo "[!] ERROR!! Path ${1} does not exist"
    fi
}


# Creates new virtual environment if ran with -n | --new flag
function _pysetenv_create()
{
    if [ -z ${1} ];
    then
        echo "[!] ERROR!! Please pass virtual environment name!"
        _pysetenv_help_
    else
        echo "[+] Adding new virtual environment: $1"

        if [ ${PYSETENV_PYTHON_VERSION} -eq 3 ];
        then
            ${PYSETENV_PYTHON_PATH} -m venv ${PYSETENV_VIRTUAL_DIR_PATH}${1}
        else
            virtualenv -p ${PYSETENV_PYTHON_PATH}${PYSETENV_VIRTUAL_DIR_PATH}${1}
        fi

        echo "[*] Activate python virtual environment using this command: pysetenv ${1}"
    fi
}


 # Deletes existing virtual environment if ran with -d|--delete flag
function _pysetenv_delete()
{
    if [ -z ${1} ];
    then
        echo "[!] ERROR!! Please pass virtual environment name!"
        _pysetenv_help_
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
            echo "[!] ERROR!! No virtual environment exists byt he name: ${1}"
        fi
    fi
}


# Lists all virtual environments if ran with -l|--list flag
function _pysetenv_list()
{
    echo -e "[*] List of virtual environments you have under ${PYSETENV_VIRTUAL_DIR_PATH}:\n"
    for v in $(ls -l "${PYSETENV_VIRTUAL_DIR_PATH}" | egrep '^d' | awk -F " " '{print $NF}' )
    do
        echo ${v}
    done
}


# Main function
function pysetenv()
{
    if [ $# -eq 0 ]; # If no argument show help
    then
        _pysetenv_help_
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
                    echo "[!] ERROR!! virtual environment with name ${1} does not exist"
                    _pysetenv_help_
                fi
                ;;
        esac
    elif [ $# -le 5 ];
    then
        case "${2}" in
            -p|--python) _pysetenv_custom_python_path ${3}${4};;
            *) _pysetenv_help_
        esac
    fi
}