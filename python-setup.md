# Installed on both Windows and WSL independently

## Windows
https://ianchanning.wordpress.com/2016/03/25/jupyter-on-windows-with-chocolatey/

choco install python

pip install jupyter

## WSL - Debian

Install using pyenv

# Typical pyenv setup

https://www.youtube.com/watch?v=gIo22v3BIh8

For `<name>` its common to use `project_env`
```
pyenv local 3.11.5
python -m venv <name>
source <name>/bin/activate
pip install -r requirements.txt

```
Older method:
```
pyenv virtualenv <virtual_env_name>
pyenv virtualenv
  3.11.5/envs/AZURE-AI-SEARCH (created from /home/wkotzan/.pyenv/versions/3.11.5)
  AZURE-AI-SEARCH (created from /home/wkotzan/.pyenv/versions/3.11.5)


```

# Poetry useful commands 

`pip install poetry` - Install
`poetry env info` - environment information

Virtual environment - make sure you delete existing one
`poetry config virtualenv.in-project true` - sets it to in-project virtual environment in `.venv` folder

`poetry shell` - opens a shell in the context of the virtual environment

`poetry add <package>`

Poetry can be used to build and publish packages
`poetry config reponsitories.<name> https://<name>.pypi.org/legacy`


# Virtual Environments

* In Windows, venv directory to activate is Scripts, Linux it's in bin 

### virtualenv

First need to install virtualenv
`virtualenv <name>`
`source <name>/bin/activate` - activates it

### venv

Part of Python standard library
`python3 -m venv <name>`
`source <name>/bin/activate` - activates it

### poetry

`poetry init`

### pip
Freeze current dependency versions:
```
pip freeze --all > requirements.txt
```


# Django
`django-admin startproject <name>`
`python manage.py run server`

Run migrations
`python manage.py migrate`

# Django apps (modules)

Create a new app module under the folder 'newapp'
`python manage.py startapp newapp`

### Jupyter notebook

To run jupyter: `jupyter lab` or `jupyter notebook` or `jupyter server` - get the URL from the console output that follows

