#!/bin/bash
LOG_LOCATION='/tmp'
LOG_PREFIX='texmaker-workspace'
LOG_SUFFIX='output.log'
: "${LOG_LEVEL:-texmaker}"
LOG_TAIL=${LOG_LOCATION}/${LOG_PREFIX}-${LOG_LEVEL}-${LOG_SUFFIX}

GUAC_LOG_FILE="${LOG_LOCATION}/${LOG_PREFIX}-guacamole-${LOG_SUFFIX}"
texmaker_LOG_FILE="${LOG_LOCATION}/${LOG_PREFIX}-texmaker-${LOG_SUFFIX}"
XTERM_LOG_FILE="${LOG_LOCATION}/${LOG_PREFIX}-xterm-${LOG_SUFFIX}"

: "${DOMINO_WORKING_DIR:=/mnt}"

touch $texmaker_LOG_FILE $GUAC_LOG_FILE

# Ensure password is set for Domino user for RDP autologin to work
echo -e "domino\ndomino" | sudo passwd $DOMINO_USER_NAME &>/dev/null

# Modify the RDP username Guacamole auth
sudo sed -i "s#ubuntu#$DOMINO_USER_NAME#g" /etc/guacamole/user-mapping.xml

# Fix Guacamole iframe issue (needed for Domino workspaces to work)
FOCUS_FIX="var refocusGuacamole=function(){var e=document.activeElement;e\&\&e!==document.body||window.parent.document.querySelector(\"iframe\").focus()};document.addEventListener(\"click\",refocusGuacamole),document.addEventListener(\"keydown\",refocusGuacamole);"
cd /tmp
unzip -p /var/lib/tomcat8/webapps/guacamole.war "index.html" | sed "s#</body>#<script type=\"text/javascript\">${FOCUS_FIX}</script></body>#g" > index.html
sudo jar -uf "/var/lib/tomcat8/webapps/guacamole.war" index.html

# Configure Guacamole to not require subdomains
PREFIX="${DOMINO_PROJECT_OWNER}#${DOMINO_PROJECT_NAME}#notebookSession#${DOMINO_RUN_ID}"
sudo ln -s "/var/lib/tomcat8/webapps/guacamole.war" "/var/lib/tomcat8/webapps/${PREFIX}.war"

# Add config for jupyter proxy url
PREFIX="${DOMINO_PROJECT_OWNER}#${DOMINO_PROJECT_NAME}#notebookSession#${DOMINO_RUN_ID}#texmaker"
sudo ln -s "/var/lib/tomcat8/webapps/guacamole.war" "/var/lib/tomcat8/webapps/${PREFIX}.war"

# Save all environment variables for the RDP process to reload
export -p > $HOME/.rdp-defaults

sudo guacd >> $GUAC_LOG_FILE 2>&1
sudo service tomcat8 start >> $GUAC_LOG_FILE 2>&1 || true
sudo service xrdp start
while true; do :; done