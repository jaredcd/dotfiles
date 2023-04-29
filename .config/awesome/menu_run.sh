#!/bin/bash
source ~/.bashrc
compgen -ac | sort -u | dmenu "$@" | ${SHELL:-"/bin/bash"} &
