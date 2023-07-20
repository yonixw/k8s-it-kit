mkdir -p ~/Downloads/RoboMongo
cd ~/Downloads/RoboMongo

ZIP_PATH=$(curl -L https://github.com/MuhammedKalkan/OpenLens/releases/latest | grep -oE '[^"]+?\/releases\/[^"\s]+?\.amd64.deb' | head -n1)
EXPAND_PATH=$(curl -L https://github.com/MuhammedKalkan/OpenLens/releases/latest | grep -oE '[^"]+?\/expanded_assets\/[^"\s]+?' | head -n1 )

echo "1ZIP_PATH=->$ZIP_PATH<-"
echo "EXPAND_PATH=->$EXPAND_PATH<-"

# If empty, grep from expanded_assets
if [[ -z $ZIP_PATH ]]
then
	ZIP_PATH=$(curl $EXPAND_PATH  | grep -oE '[^"]+release[^"]+\.amd64.deb' | head -n1)
fi

echo "2ZIP_PATH=->$ZIP_PATH<-"

if [[ -z $ZIP_PATH ]]
then
        echo "Can't find latest release from MangaPrinter, exiting..."
	    exit -1
fi

echo "3ZIP_PATH=->$ZIP_PATH<-"

if [[ ! $ZIP_PATH = http* ]]
then
	echo "Adding https github to link"
	ZIP_PATH=https://github.com$ZIP_PATH
fi

echo "4ZIP_PATH=$ZIP_PATH"

set -e # exit on any fail

echo "Download file"
#hexdump -C <<<"$ZIP_PATH"
wget -O openlens.amd64.deb $ZIP_PATH
ls -la

apt install -y libgtk-3-0 libnotify4 xdg-utils libatspi2.0-0 libsecret-1-0 libgbm-dev

echo "Install Openlens"
dpkg -i openlens.amd64.deb

# kubectl
# expected in  /root/.config/OpenLens/binaries/kubectl
mkdir -p _kubectl
cd _kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

install -o root -g root -m 0755 kubectl /root/.config/OpenLens/binaries/kubectl

/root/.config/OpenLens/binaries/kubectl version --client
cd ..
rm -rf _kubectl


echo "Update menu to (fail if not found): $EXE_PATH"

echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OpenLens (K8s)\" command=\"export QT_X11_NO_MITSHM=1 && /opt/OpenLens/open-lens  --no-sandbox --disable-gpu  --in-process-gpu --disable-software-rasterizer --no-xshm --disable-dev-shm-usage" \"" \
    >> /usr/share/menu/custom-docker && update-menus
