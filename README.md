# Simtools as a docker container

## Introduction
This files provides a way to run simtools as a docker container. The purpose is to allow simctl to be used straighforward without syntax changes or additional commands.   

## Prerequisites
Sudo is used by the installer to grant administrator privileges. Accordingly, you need to have sudo install in your system before using the install script, or modify it by yourself to provide an alternative way to raise your provileges. 

## Install
To install the container just run the commands below.
- \# chmod u+x simtools_install.sh
- ./simtools_install.sh

Once the docker image has been installed and it's running, open a console and use the *simctl* command to manage the simtools scenarios. 
