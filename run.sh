docker run \
     -v /var/run/docker.sock:/var/run/docker.sock \
     -v $(pwd)/dbeaver-plugins:/root/.local/share/DBeaverData/drivers \
     -v $(pwd)/dbeaver-config:/root/.local/share/DBeaverData/workspace6/.metadata/.config/ \
    --shm-size=256m \
    --rm -it \
    -p 5901:5901 \
    yonixw/k8s-it-kit