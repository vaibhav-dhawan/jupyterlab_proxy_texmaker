#!/bin/bash

# Load Domino environment variables
source $HOME/.domino-defaults
source $HOME/.rdp-defaults

# Configure Fluxbox
mkdir $HOME/.fluxbox
echo "session.screen0.toolbar.tools:  iconbar, systemtray" > $HOME/.fluxbox/init
echo "background: none" > $HOME/.fluxbox/overlay

# Launch MATLAB
cd $DOMINO_WORKING_DIR
fluxbox &
xterm -e texmaker