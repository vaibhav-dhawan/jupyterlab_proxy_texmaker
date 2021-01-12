USER root

RUN wget -q -O /tmp/mrutter.asc "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xe298a3a825c0d65dfd57cbb651716619e084dab9" && \
    sudo apt-key add /tmp/mrutter.asc && \
    sudo apt-get update && \
    sudo apt-get install texmaker -y

RUN sudo DEBIAN_FRONTEND=noninteractive apt install -y vnc4server expect openbox tightvncserver tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer xrdp
RUN sudo apt install -y build-essential libcairo2-dev libjpeg-turbo8-dev libpng-dev libtool-bin libossp-uuid-dev libvncserver-dev freerdp2-dev libssh2-1-dev libtelnet-dev libwebsockets-dev libpulse-dev libvorbis-dev libwebp-dev libssl-dev libpango1.0-dev libswscale-dev libavcodec-dev libavutil-dev libavformat-dev
RUN cd /opt && wget http://mirror.cc.columbia.edu/pub/software/apache/guacamole/1.2.0/source/guacamole-server-1.2.0.tar.gz && tar -xvf guacamole-server-1.2.0.tar.gz && cd guacamole-server-1.2.0 && ./configure --with-init-dir=/etc/init.d && sudo make && sudo make install && sudo ldconfig
RUN sudo apt install -y default-jdk tomcat8 tomcat8-admin tomcat8-common tomcat8-user && cd /tmp && wget https://downloads.apache.org/guacamole/1.2.0/binary/guacamole-1.2.0.war && sudo mv guacamole-1.2.0.war /var/lib/tomcat8/webapps/guacamole.war
RUN sudo apt install -y fluxbox

# Pull required code
RUN mkdir /tmp/gittex && \
    cd /tmp/gittex && \
    git clone https://github.com/vaibhav-dhawan/jupyterlab_proxy_texmaker.git
    
RUN sudo mkdir /etc/guacamole/ && \
    cp /tmp/gittex/jupyterlab_proxy_texmaker/supporting/user-mapping.xml /etc/guacamole/user-mapping.xml && \
    mkdir /var/opt/workspaces/texmaker && \
    cp /tmp/gittex/jupyterlab_proxy_texmaker/supporting/start.sh /var/opt/workspaces/texmaker/start.sh && \
    cp /tmp/gittex/jupyterlab_proxy_texmaker/supporting/rdp.sh /var/opt/workspaces/texmaker/rdp.sh && \
    chmod a+x /var/opt/workspaces/texmaker/*.sh && \
    cp /tmp/gittex/jupyterlab_proxy_texmaker/supporting/guacamole.properties /etc/guacamole/ 
# Vaibhav: Noauth plugin, currently not working:
#    cp /tmp/gittex/jupyterlab_proxy_texmaker/supporting/noauth-config.xml /etc/guacamole/ && \
#    sudo mkdir -p /var/lib/guacamole/classpath  && \
#    cp /tmp/gittex/jupyterlab_proxy_texmaker/supporting/guacamole-auth-noauth-1.2.0.jar /var/lib/guacamole/classpath && \
#    sudo mkdir -p /etc/guacamole/extensions  && \
#    cp /tmp/gittex/jupyterlab_proxy_texmaker/supporting/guacamole-auth-noauth-1.2.0.jar /etc/guacamole/extensions && \
#    sudo mkdir -p /etc/guacamole/lib  && \
#    cp /tmp/gittex/jupyterlab_proxy_texmaker/supporting/guacamole-auth-noauth-1.2.0.jar /etc/guacamole/lib    
    
RUN cd /tmp/gittex/jupyterlab_proxy_texmaker && pip install .