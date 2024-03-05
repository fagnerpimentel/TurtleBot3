# TurtleBot3

## build
docker compose build
docker compose up ros-master

## simulation
ros2 launch turtlebot3_gazebo empty_world.launch.py
ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py

## teleop
ros2 run turtlebot3_teleop teleop_keyboard

## mapping
ros2 launch turtlebot3_cartographer cartographer.launch.py
ros2 run nav2_map_server map_saver_cli -f ~/map

## criando um pacote
mkdir src
cd src
ros2 pkg create <nome_do_pacote> --build-type ament_python

## criando um no

- crie um anquivo python
- use o seguinte código:
    robot.py


- edite o arquivo setup.py:

entry_points={
        'console_scripts': [
            'binario = nome_do_pacote.nome_do_no:main'
        ],
    },