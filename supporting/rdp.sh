#!/bin/bash

# Load Domino environment variables
source $HOME/.domino-defaults
source $HOME/.rdp-defaults

# Configure Fluxbox
mkdir $HOME/.fluxbox
#echo "session.screen0.toolbar.visible: false" > $HOME/.fluxbox/init
echo "session.screen0.toolbar.tools:  iconbar, systemtray" > $HOME/.fluxbox/init
echo "session.screen0.titlebar.left:  Stick" >> $HOME/.fluxbox/init 
echo "session.screen0.titlebar.right: Maximize" >> $HOME/.fluxbox/init
echo "background: none" > $HOME/.fluxbox/overlay

# Launch Texmaker
cd $DOMINO_WORKING_DIR
fluxbox &
texmaker
