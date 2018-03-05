#!/bin/bash
cd /tmp || exit
echo "Downloading Postman ..."
wget -q https://dl.pstmn.io/download/latest/linux?arch=64 -O postman.tar.gz
tar -xzf postman.tar.gz
rm postman.tar.gz

echo "Installing to opt ..."
if [ -d "/opt/Postman" ];then
    sudo rm -rf /opt/Postman
fi
sudo mv Postman /opt/Postman

echo "Creating symbolic link ..."
if [ -L "/usr/bin/postman" ];then
    sudo rm -f /usr/bin/postman
fi
sudo ln -s /opt/Postman/Postman /usr/bin/postman

echo "Creating .desktop file ..."
if [ -e "~/.local/share/applications/postman.desktop" ];then
    sudo rm ~/.local/share/applications/postman.desktop
fi
cat > ~/.local/share/applications/postman.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOL

echo "Installation completed, Lets Rock!"
