#!/bin/bash

# Install X Windows and Firefox for local operation, and Samba for media sharing.
sudo yum groupinstall "X Window System" -y
sudo yum install -y gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts
sudo yum install -y firefox
sudo yum install -y samba

# Default ot GUI on bootup, and push a default X config - only required to set the screen resolution.
sudo systemctl set-default graphical.target
sudo cp xorg.conf /etc/X11/xorg.conf

##### Samba
# Push Samba configuration
sudo cp /etc/samba/smb.conf /etc/samba/smb.orig
sudo cp smb.conf /etc/samba/smb.conf

# Configure the Samba user
sudo groupadd samba
sudo useradd media -G samba

# Make the Samba media share, and permission accordingly.
sudo mkdir -p /samba/media
sudo chmod -R 0755 /samba/media/
sudo chown -R media:samba /samba/media/
sudo chcon -t samba_share_t /samba/media/

# Set the password for the media user
echo 'Password02' | tee - | sudo smbpasswd -s -a media

# Configure Samba for autostart
sudo systemctl start smb.service
sudo systemctl enable smb.service
###### End of Samba

# Set timezone to NZ
sudo timedatectl set-timezone Pacific/Auckland
sudo timedatectl set-local-rtc 0

# Mount the isos on boot.
sudo cp isomount /etc/init.d/isomount
sudo chmod 0755 /etc/init.d/isomount
sudo chkconfig isomount on
sudo service isomount start

# Push the default homepage into Firefox. Note - needs to run as the "normal" user, hence no sudo.
echo "user_pref(\"browser.startup.homepage\",\"http://localhost:8080\");" >> /home/vagrant/.mozilla/firefox/$(cat /var/jenkins_user/.mozilla/firefox/profiles.ini | grep Path | sed s/^Path=//)/prefs.js
