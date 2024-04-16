# TurtleBot3

## inicializando o robô

### Robô real:
- [configurando Raspberry Pi](doc/config_rbp.md)

### Robô simulado:
- docker compose build
- docker compose up ros-master
- ros2 launch turtlebot3_gazebo empty_world.launch.py
- ros2 launch turtlebot3_gazebo turtlebot3_house.launch.py

## Teleoperação
- ros2 run turtlebot3_teleop teleop_keyboard

## Mapeamento
- ros2 launch turtlebot3_cartographer cartographer.launch.py
- ros2 run nav2_map_server map_saver_cli -f src/map

## Navegação
- ros2 launch turtlebot3_navigation2 navigation2.launch.py map:=src/map.yaml

## Criando um pacote
- mkdir src
- cd src
- ros2 pkg create <nome_do_pacote> --build-type ament_python

## Criando um nó
- crie um anquivo python
- use o seguinte código:
    - robot.py
- edite o arquivo setup.py:

```python
entry_points={
        'console_scripts': [
            'binario = nome_do_pacote.nome_do_no:main'
        ],
    },
```

# Fontes:
Material adaptado de:
- https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
- https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/
- https://github.com/ROBOTIS-GIT/turtlebot3.git
- https://github.com/ROBOTIS-GIT/ld08_driver.git 