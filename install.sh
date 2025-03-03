#!/bin/bash

ansible-playbook ansible/install.yaml --ask-become-pass --extra-vars="app_name=remrob-app" --tags=common,remrob-server,remrob-webapp