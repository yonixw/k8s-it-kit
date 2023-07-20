# exit when any command fails
set -e

apt update && \
    apt -y install libgtkextra-dev libgconf2-dev \
                   libnss3 libasound2 libxtst-dev libxss1
apt install -y wget curl lsb-release

# clean
apt clean all