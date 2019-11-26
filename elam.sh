sudo apt-get update
sudo touch /etc/apt/apt.conf.d/02proxy

#sudo echo "Acquire::http { Proxy \"http://192.168.12.7:3142\"; };" > /etc/apt/apt.conf.d/02proxy

echo "Installing libncurses5-dev bison flex texinfo minicom xientd tftp-hpa tftpd-hpa picocom lrzsz gawk lzop g++ u-boot-tools dfu-programmer"

sudo apt-get install --assume-yes build-essential gcc libncurses5-dev bison flex texinfo minicom xinetd tftp-hpa tftpd-hpa picocom lrzsz gawk lzop g++ u-boot-tools patch dfu-programmer

echo "Creating tftp directory"
sudo touch /etc/xinetd.d/tftp

echo " Setting up tftp configuration"
cat > /etc/xinetd.d/tftp << END
service tftp
{
protocol        = udp
port            = 69
socket_type     = dgram
wait            = yes
user            = nobody
server          = /usr/sbin/in.tftpd
server_args     = /var/lib/tftpboot
disable         = no
}
END

echo "Creating tftpboot directory"
sudo mkdir /var/lib/tftpboot

echo "Changing the permission of tftpboot directory"
sudo chmod -R 777 /var/lib/tftpboot

echo "Changing the owner of the tftpboot directory"
sudo chown -R nobody.root /var/lib/tftpboot

sudo /etc/init.d/xinetd restart
echo "Package installed successfully"


#bash /home/shared-tools/bin/crontab.sh
#dpkg -i /home/shared-tools/bin/ubuntu16MCpkg/python-*
