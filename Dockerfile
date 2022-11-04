FROM guacamole/guacamole
WORKDIR /opt/guacamole
COPY guacamole-docker/bin/ /opt/guacamole/bin/

EXPOSE 8080
CMD ["/opt/guacamole/bin/start.sh"]