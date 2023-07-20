mkdir -p ~/Downloads/RoboMongo
cd ~/Downloads/RoboMongo

ZIP_PATH=$(curl -L https://github.com/Studio3T/robomongo/releases/latest | grep -oE '[^"]+\/releases\/[^"]+\.tar.gz' | head -n1)
EXPAND_PATH=$(curl -L https://github.com/Studio3T/robomongo/releases/latest | grep -oE '[^"]+\/expanded_assets\/[^"]+' | head -n1)

echo "EXPAND_PATH=$EXPAND_PATH"

# If empty, grep from expanded_assets
if [[ -z $ZIP_PATH ]]
then
	ZIP_PATH=$(curl $EXPAND_PATH  | grep -oE '[^"]+release[^"]+\.tar.gz' | head -n1)
fi

echo "ZIP_PATH=$ZIP_PATH"


if [[ -z $ZIP_PATH ]]
then
        echo "Can't find latest release from MangaPrinter, exiting..."
	exit -1
fi

if [[ ! $ZIP_PATH = http* ]]
then
	echo "Adding https github to link"
	ZIP_PATH=https://github.com$ZIP_PATH
fi

set -e # exit on any fail

echo "Download file"
wget -O robomongo.tar.gz "$ZIP_PATH"
ls -la

echo "Extract tar.gz"
tar -xvf robomongo.tar.gz

echo "Update menu to (fail if not found): $EXE_PATH"
# https://askubuntu.com/a/1033450/570936 ~+ = full path of pwd in bash, or use 'pwd -P'
EXE_PATH=$(find ~+ | grep /bin/robo3t)

echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"RoboMongo\" command=\"xterm -ls -bg black -fg white -fs 14 -fa DejaVuSansMono -e \\\"$EXE_PATH\\\" \"" \
    >> /usr/share/menu/custom-docker && update-menus
