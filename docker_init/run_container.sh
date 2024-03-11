#!/bin/bash
c=5;
new_user=syy
new_pwd=314

mkdir -p /var/docker_container/cont_space/"$new_user"_"$c"
sudo docker run -idt \
    -h srv3 \
    -p "$((15000+c)):22" \
    --gpus all \
    --name "$new_user"_"$c" \
    --ipc=host \
    --mount type=bind,source=/var/docker_container/public_data,target=/home/data,readonly \
    --mount type=bind,source=/var/docker_container/shared_data,target=/home/share \
    --mount type=bind,source=/var/docker_container/cont_space/"$new_user"_"$c",target=/home/$new_user \
    -e NEW_USER=$new_user \
    -e NEW_PWD=$new_pwd \
    nvdocker:v1 /bin/bash
