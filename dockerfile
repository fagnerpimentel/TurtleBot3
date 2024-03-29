ARG DEBIAN_FRONTEND=noninteractive 
ARG IMG=osrf/ros:humble-desktop-full
# ARG IMG=arm64v8/ros:humble-ros-core

FROM ${IMG}

ENV ROS_DISTRO=humble

SHELL [ "/bin/bash" , "-c"]

RUN apt-get update
RUN apt install -y xterm tmux git

# cria e determina diretório da area de trabalho
RUN mkdir /turtlebot3_ws
RUN mkdir /turtlebot3_ws/src
RUN cd /turtlebot3_ws/src && git clone -b humble-devel https://github.com/ROBOTIS-GIT/turtlebot3.git
# RUN cd /turtlebot3_ws/src && git clone -b ros2-devel https://github.com/ROBOTIS-GIT/ld08_driver.git

RUN if [ "$IMG" = "osrf/ros:humble-desktop-full" ]; then \
        apt install -y ros-${ROS_DISTRO}-gazebo-ros; \
        apt install -y ros-${ROS_DISTRO}-gazebo-ros-pkgs; \
        apt install -y ros-${ROS_DISTRO}-turtlebot3-gazebo; \ 
    # elif [ "$IMG" = "arm64v8/ros:humble-ros-core" ]; then \
    else \
        echo "No valid webserver specified"; \
    fi

RUN apt install -y ros-${ROS_DISTRO}-cartographer
RUN apt install -y ros-${ROS_DISTRO}-cartographer-ros
RUN apt install -y ros-${ROS_DISTRO}-navigation2
RUN apt install -y ros-${ROS_DISTRO}-nav2-bringup
RUN apt install -y ros-${ROS_DISTRO}-dynamixel-sdk
RUN apt install -y ros-${ROS_DISTRO}-turtlebot3-msgs
RUN apt install -y ros-${ROS_DISTRO}-turtlebot3
RUN apt install -y ros-${ROS_DISTRO}-hls-lfcd-lds-driver
RUN apt install -y ros-${ROS_DISTRO}-dynamixel-sdk

RUN apt install -y python3-argcomplete 
RUN apt install -y python3-colcon-common-extensions 
RUN apt install -y libboost-system-dev 
RUN apt install -y build-essential
RUN apt install -y libudev-dev
# RUN cd /turtlebot3_ws/src/turtlebot3
# RUN rm -r turtlebot3_cartographer turtlebot3_navigation2

# RUN rm -R usr/src/gmock
# RUN rm -R usr/src/gtest
# RUN rm -R usr/share/urdfdom/
# RUN cd /turtlebot3_ws/
# RUN source /opt/ros/humble/setup.bash && colcon build --symlink-install --parallel-workers 1

# RUN cd ~/turtlebot3_ws/
# RUN echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
# RUN source ~/.bashrc
# RUN colcon build --symlink-install --parallel-workers 1
# RUN echo 'source ~/turtlebot3_ws/install/setup.bash' >> ~/.bashrc
# RUN source ~/.bashrc

# RUN echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc
# RUN source ~/.bashrc

# RUN echo 'export LDS_MODEL=LDS-02' >> ~/.bashrc
# RUN source ~/.bashrc

# RUN echo 'TURTLEBOT3_MODEL=burger' >> ~/.bashrc
# RUN source ~/.bashrc

# config tmux
RUN echo "unbind -n Tab"                                                                    >> ~/.tmux.conf
RUN echo "set -g window-style        'fg=#ffffff,bg=#8445ca'"                               >> ~/.tmux.conf
RUN echo "set -g window-active-style 'fg=#ffffff,bg=#5e2b97'"                               >> ~/.tmux.conf
RUN echo "set-option -g default-shell '/bin/bash'"                                          >> ~/.tmux.conf
RUN echo "run-shell '. /opt/ros/humble/setup.bash'"                                         >> ~/.tmux.conf
RUN echo "set -g mouse on"                                                                  >> ~/.tmux.conf 
RUN echo "bind-key -n C-Left select-pane -L"                                                >> ~/.tmux.conf
RUN echo "bind-key -n C-Right select-pane -R"                                               >> ~/.tmux.conf
RUN echo "bind-key -n C-Up select-pane -U"                                                  >> ~/.tmux.conf
RUN echo "bind-key -n C-Down select-pane -D"                                                >> ~/.tmux.conf
RUN echo "bind -n M-Right split-window -h"                                                  >> ~/.tmux.conf
RUN echo "bind -n M-Down split-window -v"                                                   >> ~/.tmux.conf

WORKDIR /turtlebot3_ws
