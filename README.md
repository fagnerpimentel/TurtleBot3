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


## Checkpoints

<details>
<summary>checkpoints.py</summary>

```python
import rclpy
from rclpy.action import ActionClient
from rclpy.node import Node

from nav2_msgs.action import FollowWaypoints
from geometry_msgs.msg import PoseStamped
from std_srvs.srv import Trigger
import json

class Checkpoints(Node):

    def __init__(self):
        super().__init__('checkpoints')
        self.goal_handle = None
        self._action_client = ActionClient(self, FollowWaypoints, '/follow_waypoints')
        self.srv_start = self.create_service(Trigger, '/start', self.start_callback)
        self.srv_cancel = self.create_service(Trigger, '/cancel', self.cancel_callback)
        self.declare_parameter('checkpoints_file', '')

    def start_callback(self, request, response):

        try:
            checkpoints_file = self.get_parameter('checkpoints_file').get_parameter_value().string_value

            f = open(checkpoints_file)
            data = json.load(f)

            poses = []
            for i in data['poses']:
                p = PoseStamped()
                p.header.frame_id = data['frame_id']
                p.pose.position.x = i['position']['x']
                p.pose.position.y = i['position']['y']
                p.pose.position.z = i['position']['z']
                p.pose.orientation.x = i['orientation']['x']
                p.pose.orientation.y = i['orientation']['y']
                p.pose.orientation.z = i['orientation']['z']
                p.pose.orientation.w = i['orientation']['w']
                poses.append(p)

            goal_msg = FollowWaypoints.Goal()
            goal_msg.poses = poses
            self._action_client.wait_for_server()
            self.goal_handle = self._action_client.send_goal_async(goal_msg)

            response.success = True
            response.message = "Success"
            return response
        except FileNotFoundError as e:
            self.get_logger().error (f"{e}")
            response.success = False
            response.message = f"{e}"
            return response


    def cancel_callback(self, request, response):
        self.goal_handle.result().cancel_goal_async()

        response.success = True
        response.message = "Success"
        return response

def main(args=None):
    rclpy.init(args=args)

    action_client = Checkpoints()
    rclpy.spin(action_client)



if __name__ == '__main__':
    main()
```
</details>

<details>
<summary>checkpoints.json</summary>
 
```json
{
    "frame_id": "map",
    "poses": [
        {"position": {"x":  1.5, "y":  0.5, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 0.0, "w": 1.0}},
        {"position": {"x":  4.0, "y": -4.0, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 0.0, "w": 1.0}},
        {"position": {"x": -3.0, "y": -4.0, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 0.0, "w": 1.0}},
        {"position": {"x": -4.0, "y":  4.0, "z": 0.0}, "orientation": {"x": 0.0, "y": 0.0, "z": 0.0, "w": 1.0}}
    ]
}
```
</details>

<details>
<summary>checkpoints.launch.py</summary>
 
```python
from launch_ros.actions import Node
from launch import LaunchDescription
from ament_index_python.packages import get_package_share_directory
from launch.substitutions import LaunchConfiguration

def generate_launch_description():
    checkpoint = Node(
        package='navigation',
        executable='checkpoints',
        name='checkpoints',
        parameters=[{
            'checkpoints_file': get_package_share_directory('navigation')+'/launch/checkpoints.json'
        }],
    )

    ld = LaunchDescription()
    ld.add_action(checkpoint)
    return ld

```
</details>

<details>
<summary>setup.py</summary>

```python
from setuptools import find_packages, setup

package_name = 'navigation'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        ('share/' + package_name + '/launch', ['launch/checkpoints.launch.py']),
        ('share/' + package_name + '/launch', ['launch/checkpoints.json']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='root',
    maintainer_email='root@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'checkpoints = navigation.checkpoints:main'
        ],
    },
)
```
</details>

# Fontes:
Material adaptado de:
- https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debians.html
- https://emanual.robotis.com/docs/en/platform/turtlebot3/overview/
- https://github.com/ROBOTIS-GIT/turtlebot3.git
- https://github.com/ROBOTIS-GIT/ld08_driver.git 