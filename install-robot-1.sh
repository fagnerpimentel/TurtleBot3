# sudo cp -rf 50-cloud-init.yaml /etc/netplan/
sudo cp -rf 20auto-upgrades /etc/apt/apt.conf.d/

systemctl mask systemd-networkd-wait-online.service
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

sudo cp 99-turtlebot3-cdc.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

sudo apt update
sudo apt install 

reboot