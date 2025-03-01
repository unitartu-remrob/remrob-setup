#!/bin/bash

ansible-playbook ansible/install.yaml --ask-become-pass --extra-vars="app_name=remrob-app"

bash ./image-build.sh --clone-dir $HOME/remrob-app