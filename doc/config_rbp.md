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
    - No terminal do Raspberry:
        - Clone este repositório: 
            - ```git clone https://github.com/fagnerpimentel/TurtleBot3.git```
        - Acesse o repositório:
            - ```cd TurtleBot3```  
        - Execute a instalação do robô:
            - ```sudo sh install-robot.sh```
            - Esse processo pode levar vários minutos.
            - No final deste processo o raspberry irá reiniciar.
        - Configure o ROS_DOMAIN_ID do seu robô:
            - ```echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc```
            - ```source ~/.bashrc```
            - Esse ID precisa ser único para cada robô na rede.
            - O valor padrão é 30. Use outros valores caso você tenha mais robôs na mesma rede.


