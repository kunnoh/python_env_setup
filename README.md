# Python installer and virtual environment setup script

This is a script used to setup and manage python3 projects & virtual environments.  
Works on popular linux OS Debian, Ubuntu, Redhat, CentOs, Fedora
It provides the following features:
- Create a new virtual environment.  
- Delete a virtual environment.  
- List existing virtual environments.  
- Load existing python3 project.  

## INSTALLATION

```sh
    curl https://raw.githubusercontent.com/connessionetech/python-installer/master/install.sh | sh -
```  

#### USAGE
The command used is **pysetenv**.  
        - **pysetenv -h name| pysetenv --help name** to show pysetenv usage.  
        - **pysetenv -l name| pysetenv --list name** to list existing virtual environments.  
        - **pysetenv -n name| pysetenv --new name** to create new virtual environment.  
        - **pysetenv -d name| pysetenv --delete name** to delete a virtual environment.  
    </ul>

#### CONFIGURATION
Configurables are.  
- **PYSETENV_VIRTUAL_DIR_PATH**  This is the root Path for virtual environments.  
- **PYSETENV_PYTHON_VERSION**  This the python version to use. The default is python3.  
- **PYSETENV_PYTHON_PATH** This is the python installation folder in the system.  

#### Switching between virtual environment
on the terminal type the following to switch from foo to bar virtual environment.  
```sh
pysetenv bar
```  
#### Deactivate
Type this on terminal to deactivate virtual environment.  
```sh
deactivate
```  


## Supported platforms

| OS  | Python Versions  | Comment/note  | 
|---|---|---|---|---|
| Ubuntu 20.x  | |   |   |   |
| Ubuntu 18.x  | 3.6, 3.7, 3.8 |   |   |   |
| Ubuntu 16.x  | 3.5, 3.6, 3.7, 3.8, 3.9 |   |
| Debian 10 | 3.5, 3.6, 3.7, 3.8, 3.9 |   |
| CentOs 6.x | x |   |   |   |
| CentOs 7.x | 3.5, 3.6, 3.7, 3.8, 3.9 |   |
| CentOs 8.x | 3.5, 3.6, 3.7, 3.8, 3.9 |   |
| Red Hat 7.x | 3.5, 3.6, 3.7, 3.8, 3.9 |   |
| Red Hat 8.x | 3.5, 3.6, 3.7, 3.8, 3.9 |   |
