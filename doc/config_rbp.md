# Configurando o Raspberry Pi
- Instale [Raspberry Pi Imager](https://www.raspberrypi.com/software/).
- Install Ubuntu 22.04 usando o Raspberry Pi Imager. 
    - Insira um cartão micro SD no computador.
    - Inicialize o Raspberry Pi Imager
    - Clique em 'CHOOSE OS'.
    - Selecione 'Other gerneral-purpose OS'.
    - Selecione 'Ubuntu'.
    - Selecione 'Ubuntu Server 22.04.4 LTS (64-bit)'.
    - Clique 'CHOOSE STORAGE' e selecione o cartão micro SD.
    - Clique no simbolo de engrenagem para editar a intalação.
    - Marque o campo 'Enable ssh'. Marque o campo 'Use password autentication'
    - Marque o campo 'Set username and password'. Escolha o login e senha que voce quer utilizar.
    - Clique em salvar.
    - Clique em 'WRITE' para instalar o sistema.
    - Espere concluir a intalação.
- Desabilite a atualização automática do sistema no micro SD:    
    - Edite o arquivo '/writable/etc/apt/apt.conf.d/20auto-upgrades'.
    - Utilize a seguinte configuração:
        ```yaml
        APT::Periodic::Update-Package-Lists "0";
        APT::Periodic::Unattended-Upgrade "0";
        ```
- Configure a rede no micro SD.
    - Edite o arquivo '/writable/etc/netplan/50-cloud-init.yaml'.
    - Utilize a seguinte configuração:
        ```yaml
        network:
        version: 2
        renderer: networkd
        ethernets:
            eth0:
            dhcp4: yes
            dhcp6: yes
            optional: true
        wifis:
            wlan0:
            dhcp4: yes
            dhcp6: yes
            access-points:
                # FEI-K404:
                # password: K$2812sD
                <ssid>:
                password: <password>
            addresses: [<ip>/24]  

        ```
        - lembre-se de substutuir ```<ssid>``` para o nome da sua rede wifi, ```<password>``` para a senha da sua rede wifi e ```<ip>``` para o ip fixo do seu robô.
- Intalando o TurtleBot3 no Raspberry Pi.
    - Inicialize o Raspberry com o cartão micro SD.
    - Acesse o Raspberry usando SSH
    - ```ssh <user>@<ip>```. Altere ```<user>``` para o usuario que voce configurou o Raspberry. Altere ```<ip>``` para o ip que voce configurou a rede do Raspberry. Será solicitado a senha que voce usou para configurar o Raspberry.
    - No terminal do Raspberry, execute os seguintes passos:
        <details>
        <summary>Clone este repositório e entre na pasta</summary>

        ```bash
        git clone https://github.com/fagnerpimentel/TurtleBot3.git
        cd TurtleBot3
        ```

        </details>


        <details>
        <summary>Configure os pacotes de instalação</summary>
        
        ```bash 
            systemctl mask systemd-networkd-wait-online.service
            sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

            sudo apt update
            sudo apt install 

            sudo apt install software-properties-common
            sudo add-apt-repository universe -y
            sudo apt update && sudo apt install curl -y
            sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

            reboot

        ```
        - No final deste processo o raspberry irá reiniciar.

        </details>

        <details>
        <summary>Instale os pacotes necessários</summary>
        
        ```bash 
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
            
            echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
            source ~/.bashrc

            sudo cp `ros2 pkg prefix turtlebot3_bringup`/share/turtlebot3_bringup/script/99-turtlebot3-cdc.rules /etc/udev/rules.d/
            sudo udevadm control --reload-rules
            sudo udevadm trigger

            echo 'export TURTLEBOT3_MODEL=burger' >> ~/.bashrc
            echo 'export LDS_MODEL=LDS-02' >> ~/.bashrc
            source ~/.bashrc
        ```
        </details>


        <details>
        <summary>Configure o ROS_DOMAIN_ID do seu robô</summary>
        
        ```bash
            echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc
            source ~/.bashrc
        ```
        - Esse ID precisa ser único para cada robô na rede.
        - O valor padrão é 30. Use outros valores caso você tenha mais robôs na mesma rede.

        </details>


        <details>
        <summary>Instale o driver do laser</summary>

        ```bash 
            mkdir -p ~/turtlebot3_ws/src && cd ~/turtlebot3_ws/src
            git clone -b ros2-devel https://github.com/ROBOTIS-GIT/ld08_driver.git
            cd ~/turtlebot3_ws/
            colcon build
            colcon build
            echo 'source '${PWD}'/install/setup.bash' >> ~/.bashrc
            source ~/.bashrc
        ```
        </details>


