echo "Download dbeaver"
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb

echo "Installing dbeaver"
dpkg -i dbeaver-ce_latest_amd64.deb
rm dbeaver-ce_latest_amd64.deb

# /root/.local/share/DBeaverData/drivers

echo "Add to menu"
echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"DBeaver (SQL)\" command=\"dbeaver-ce\"" \
    >> /usr/share/menu/custom-docker && update-menus
