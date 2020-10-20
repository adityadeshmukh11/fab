sudo su
echo -e "ITS AD\n"
    cd /
    mkdir /fabric
    mkdir /fabric/AD
    echo -e "version: '2.0'
services:
 comp-ad-v9:
  image: \"ad_0.0.10:latest"
  network_mode: \"host\"
  hostname: ad
  cap_add:
   - NET_ADMIN
  environment:
   - \"CORE_IP=$1\"
  volumes:
   - /AD:/dnif
  container_name: ship-ad-v9">/fabric/AD/docker-compose.yaml
  cd /fabric/AD
  echo "Your docker-compose file saved into /fabric/AD folder"
  #docker-compose up -d

