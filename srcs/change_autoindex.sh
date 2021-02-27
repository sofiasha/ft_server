#!/bin/bash
CONFIG=$(cat /etc/nginx/conf.d/nginx.conf)
INDEX_ON='autoindex on'
if [[ $CONFIG == *$INDEX_ON* ]]
then
    sed -i 's/autoindex on/autoindex off/' /etc/nginx/conf.d/nginx.conf
    echo "off"
else
    sed -i 's/autoindex off/autoindex on/' /etc/nginx/conf.d/nginx.conf
    echo "on"
fi
service nginx restart
