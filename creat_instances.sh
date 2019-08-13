#!/bin/bash

#openstack server create --flavor 3c8853a0-6e51-42f2-9fc7-663dc7a8f33f --image 39bf49a4-71fe-4259-8825-9c48ae275039 --key-name curix-key \
#--security-group curix-securitygroup --security-group 691f12bd-b072-4602-a1f6-534d0ffcac39 --network 0a6750a5-5c94-406a-9e2b-d596974dec27 \
#bono-1

#openstack volume create --image 39bf49a4-71fe-4259-8825-9c48ae275039 --size 20  bono-3 && sleep 40 &&
#openstack server create --flavor 3c8853a0-6e51-42f2-9fc7-663dc7a8f33f --volume bono-3 --key-name curix-key \
#--security-group curix-securitygroup --security-group 691f12bd-b072-4602-a1f6-534d0ffcac39 --network 0a6750a5-5c94-406a-9e2b-d596974dec27 \
#bono-3 &&  openstack server add floating ip bono-3 192.168.200.154

declare -A infos
infos=(
#    [bono-1]=192.168.200.192
#    [ellis]=192.168.200.105
    [sprout-1]=192.168.200.154
    [sprout-2]=192.168.200.136
    [sprout-3]=192.168.200.179
    [sprout-4]=192.168.200.162
    [sprout-5]=192.168.200.167
    [vellum-1]=192.168.200.137
    [vellum-2]=192.168.200.135
    [vellum-3]=192.168.200.134
    [vellum-4]=192.168.200.104
    [vellum-5]=192.168.200.185
    [dime-1]=192.168.200.158
    [dime-2]=192.168.200.145
    [dime-3]=192.168.200.124
    [dime-4]=192.168.200.160
    [dime-5]=192.168.200.111
    [homer-1]=192.168.200.186
    [homer-2]=192.168.200.189
    [homer-3]=192.168.200.125
    [homer-4]=192.168.200.165
    [homer-5]=192.168.200.197
)

VAL=1

create_server (){

openstack server create --flavor 3c8853a0-6e51-42f2-9fc7-663dc7a8f33f --volume $name-volume  --key-name curix-key \
--security-group curix-securitygroup --security-group 691f12bd-b072-4602-a1f6-534d0ffcac39 --network 0a6750a5-5c94-406a-9e2b-d596974dec27 \
--hint ram_allocation_ratio=.25 --hint max_instances_per_host=7 --availability-zone nova2 $name && sleep 5
}

for i in "${!infos[@]}"
do
name=$i-volume
openstack volume create --image 39bf49a4-71fe-4259-8825-9c48ae275039 --size 20  $name && sleep 10
done


for i in "${!infos[@]}"
do
name=$i
ipname=${infos[$i]}
create_server 
while [[ $? -gt 0 ]]
do
sleep 5
create_server
done
openstack server add floating ip $name $ipname && sleep 5
done





