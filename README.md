# TurtleBot3

docker compose build
docker compose up ros-master

export ROS_DOMAIN_ID=30 
export TURTLEBOT3_MODEL=burger 
ros2 launch turtlebot3_gazebo empty_world.launch.py
ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py
ros2 run turtlebot3_teleop teleop_keyboard
