
#!/bin/bash

#################################################################
# Author: Steven(Wei) Su
# Email : suwei007@gmail.com 


#Color setup 
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


if [ -z ${BLOG_HOME} ]; then
    printf "hugo status:  ${RED} Not found "\$BLOG_HOME" ${NC}\n"
    exit
fi

#check if hugo is running
if pgrep hugo >/dev/null 2>&1
  then
    # hugo is running     
    printf "hugo status:  ${GREEN} Already Runnming ${NC}\n"
  else
    printf "hugo status:  ${RED} Not Running ${NC}\n"
    printf "hugo status:  ${GREEN} Starting ...${NC}\n"
    hugo server -c ${BLOG_HOME}/content --config ${BLOG_HOME}/config.toml --themesDir ${BLOG_HOME}/themes
    
fi

