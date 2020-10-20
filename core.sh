sudo su
echo -e "ITS CORE..\n"
    sleep 2
    cd /
    mkdir /fabric
    cd /fabric
    echo -e "version: '2.0'
services:
 comp-ship-an:
   image: "core_0.0.10:latest"
   network_mode: \"host\"
   cap_add:
    - NET_ADMIN
   ports:
    - \"9200:9200/tcp\"
    - \"9300:9300/tcp\"
   volumes:
    - /CO:/dnif
   environment:
    - \"CORE_IP=$1\"
   ulimits:
    memlock:
     soft: -1
     hard: -1
   container_name: comp-dnif-core" >/fabric/docker-compose.yml
   echo "Your docker-compose file saved into /fabric folder"
  #docker-compose up -d

