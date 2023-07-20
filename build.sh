git clone https://github.com/bandi13/gui-docker guidocker
cd guidocker

# tigervnc-tools: https://github.com/microsoft/vscode-dev-containers/issues/1428

cat Dockerfile | \
    sed 's/FROM.*/FROM ubuntu:23.10/' | \
    sed 's/ python / python3 python-is-python3 /g' | \
    sed 's/ python-numpy / python3-numpy /g' | \
    sed 's/ tigervnc-common / tigervnc-common tigervnc-tools /g' | \
    sed 's/RUN useradd -m -s/RUN useradd -o -m -s/g' \
    > Dockerfile.local

#https://askubuntu.com/a/1387849/570936
sed -i 's/fi/fi\nsleep 360d/' x11vnc_entrypoint.sh

docker build -f Dockerfile.local -t bandi13/gui-docker:local .

cd ..
cat dbeaver-plugins-cache-parts/dbeaver-plugins-tar-gz* > dbeaver-plugins.tar.gz
docker build -t yonixw/k8s-it-kit .
rm dbeaver-plugins.tar.gz