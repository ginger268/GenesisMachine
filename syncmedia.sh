sudo mkdir /mediasync -p
sudo mount -t cifs -o username=administrator,password=Password01 //192.168.150.60/genesismedia /mediasync
sudo rsync --delete --itemize-changes -avptz --modify-window=2 /mediasync/ /samba/media
sudo chown -R media:samba /samba/media
