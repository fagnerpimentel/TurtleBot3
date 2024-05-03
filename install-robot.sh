systemctl mask systemd-networkd-wait-online.service
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

sudo apt update
sudo apt install 

sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt install -y libudev-dev
sudo apt install -y python3-argcomplete 
sudo apt install -y python3-colcon-common-extensions 
sudo apt install -y libboost-system-dev build-essential

sudo apt install -y ros-dev-tools
sudo apt install -y ros-humble-ros-base

sudo apt install -y ros-humble-dynamixel-sdk
sudo apt install -y ros-humble-hls-lfcd-lds-driver

sudo apt install -y ros-humble-turtlebot3-msgs
sudo apt install -y ros-humble-turtlebot3-node
sudo apt install -y ros-humble-turtlebot3-teleop
sudo apt install -y ros-humble-turtlebot3-bringup
sudo apt install -y ros-humble-turtlebot3-description

mkdir -p ~/turtlebot3_ws/src && cd ~/turtlebot3_ws/src
git clone -b ros2-devel https://github.com/ROBOTIS-GIT/ld08_driver.git
cd ~/turtlebot3_ws/
echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
source ~/.bashrc
colcon build
colcon build
echo 'source '${PWD}'/install/setup.bash' >> ~/.bashrc
source ~/.bashrc

sudo cp `ros2 pkg prefix turtlebot3_bringup`/share/turtlebot3_bringup/script/99-turtlebot3-cdc.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
echo 'export LDS_MODEL=LDS-02' >> ~/.bashrc
source ~/.bashrc

reboot
