sudo su
echo -e "ITS DL\n"
    echo -e "Checking for JDK /n"
    if type -p java; then
        _java=java
    elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
        echo -e "\n\nfound java executable in $JAVA_HOME \n\n"
        _java="$JAVA_HOME/bin/java"
    else
            echo -e "\n To proceed futher you have to  Install openjdk11 before installtion\n\n"
            echo "To install OpenJdk11 type YES"
            read var
            if [[ "$var" = "YES" ]]; then
                    apt-get install openjdk-11-jdk
            else
                    echo "Aborted"
                    exit
            fi
    fi

    if [[ "$_java" ]]; then
            version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
            if [[ "$version" == "11.0.8" ]]; then
                    echo -e "\n OpenJdk $version version is running\n"
            fi
    fi    
    sleep 2
    cd /
    mkdir /fabric
    mkdir /fabric/DL
    echo -e "version: '2'
services:
  datalake:
    privileged: true
    image: dl_0.0.10:latest
    network_mode: \"host\"
    cap_add:
      - NET_ADMIN
    volumes:
      - /DL:/dnif
      - /run:/run
      - /opt:/opt
      - /etc/systemd/system:/etc/systemd/system
    environment:
      - \"CORE_IP=$1\"
      - \"NET_INTERFACE=$2\"
      ">/fabric/DL/docker-compose.yaml
      cd /fabric/DL
      echo "Your dokcer-compose file saved into /fabric/LC folder"
      #docker-compose up -d

