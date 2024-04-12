# TurtleBot3

## [configurando Raspberry Pi](doc/config_rbp.md)

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




## Fontes:
Material adaptado de:
- https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
- https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/
- https://github.com/ROBOTIS-GIT/turtlebot3.git
- https://github.com/ROBOTIS-GIT/ld08_driver.git 