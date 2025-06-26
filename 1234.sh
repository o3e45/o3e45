apt update && apt upgrade
apt install sudo 

apt install -y s3fs



echo "8CNMWT4WNX1ODG2K0K43:qwsnd3QO55oeRTOKuqM7Wp6o8lTdbeNemz8ztDez" > /etc/passwd-s3fs


chmod 600 /etc/passwd-s3fs
mkdir -p /mnt/cloud/wasbai-odh-1

s3fs owendobsonholdingsllc /mnt/cloud/wasbai-odh-1 -o passwd_file=/etc/passwd-s3fs -o url=https://s3.wasabisys.com -o use_path_request_style




df -h
ls /mnt/cloud/wasbai-odh-1

echo "s3fs#owendobsonholdingsllc /mnt/cloud/wasbai-odh-1 fuse _netdev,passwd_file=/etc/passwd-s3fs,url=https://s3.wasabisys.com,allow_other,use_path_request_style 0 0" > /etc/fstab
