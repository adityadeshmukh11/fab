sudo su
echo "ITS LC"
    cd /
    mkdir fabric
    cd fabric
    mkdir LC
    cd LC
    echo -e "version: '2.2'
services:
 comp-lc-v9:
  image: "lc_0.0.7:latest"
  network_mode: \"host\"
  cap_add:
   - NET_ADMIN
  environment:
   - \"VERSION=0.5.1\"
   - \"NET_INTERFACE=$1\"    #i.e. eth0 or eth1 or whichever available in system
  volumes:
   - /dnif/LC:/dnif/lc
  container_name: ship-lc-v9-5-1

  #cpu_count: 2
  #mem_limit: 1024M
  #memswap_limit: 1024M">/fabric/LC/docker-compose.yml
  echo "Your docker-compose file save into /fabric/LC folder"
