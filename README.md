# A docker image for [OpenClash](https://github.com/vernesong/OpenClash)

## 1. File source

All the file from OpenClash repo, current release is: 

- https://github.com/vernesong/OpenClash/releases/tag/v0.45.78-beta
- https://github.com/vernesong/OpenClash/tree/master/core-lateset


## 2. Start container

```
docker start --name openclash --privileged yangyaofei/openclash:0.45.78
```

## 3. Use as a router with [macvlan](https://docs.docker.com/network/macvlan/), bridge the server's network interface

```
# create a macvlan
docker network create -d macvlan \
  --subnet=192.168.0.0/24 \ # your real network
  --gateway=192.168.0.1 \ # your real router gateway
  -o parent=eth0 \ # the network interface you want to bridge
   pub_net (network name)

docker start --name openclash --privileged --network pub_net --ip 192.168.0.2 yangyaofei/openclash:0.45.78
```

Now you can set your device's gateway to 192.168.0.2 to use openclash
