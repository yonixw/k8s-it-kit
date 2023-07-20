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

echo "Update menu to (fail if not found): $EXE_PATH"

#echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"RoboMongo\" command=\"xterm -ls -bg black -fg white -fs 14 -fa DejaVuSansMono -e \\\"$EXE_PATH\\\" \"" \
#    >> /usr/share/menu/custom-docker && update-menus

#  /opt/OpenLens/open-lens