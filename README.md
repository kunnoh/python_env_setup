# Python3 Project & Virtual Environment Setup

<p>
    This is a script used to setup and manage python3 projects & virtual environments
</p>
<p>
    Works on popular linux OS Debian, Ubuntu, Redhat, CentOs, Fedora, Kali
</p>
<p>
    It provides the following features:
</p>
<ul>
    <li>Create a new virtual environment</li>
    <li>
        Create a new virtual environment using custom Python path using -p or --python.
    </li>
    <li>Delete a virtual environment</li>
    <li>List existing virtual environments</li>
</ul>
<h4>INSTALLATION</h4>

<code>
    curl https://raw.githubusercontent.com/kunnoh/python_env_setup/master/install.sh | sh -
</code>

<h4>USAGE</h4>
<ul>
    <li>The command used is <strong>pysetenv</strong></li>
    <h4>example</h4>
    <ul>
        <li><strong>pysetenv -h | pysetenv --help</strong> to show pysetenv usage</li>
        <li><strong>pysetenv -l | pysetenv --list</strong> to list existing virtual environments</li>
    </ul>
</ul>

<h4>CONFIGURATION</h4>
<p>Configurables are</p>
<ul>
    <li><strong>PYSETENV_DIR_PATH</strong>  This is the root Path for virtual environments</li>
    <li><strong>PYSETENV_PYTHON_VERSION</strong>  This the python version to use. The default is PYSETENV_PYTHON_VERSION=3</li>
    <li><strong>PYSETENV_PYTHON_PATH</strong> This is the python installation folder in the system</li>
    <li></li>
</ul>
