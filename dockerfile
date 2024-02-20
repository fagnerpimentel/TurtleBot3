ARG IMG=osrf/ros:humble-desktop-full
FROM ${IMG}

ARG DEBIAN_FRONTEND=noninteractive 
ENV ROS_DISTRO=humble

SHELL [ "/bin/bash" , "-c"]

RUN apt-get update
RUN apt install -y xterm tmux git
RUN apt install -y ros-${ROS_DISTRO}-gazebo-ros 
RUN apt install -y ros-${ROS_DISTRO}-gazebo-ros-pkgs
RUN apt install -y ros-${ROS_DISTRO}-cartographer
RUN apt install -y ros-${ROS_DISTRO}-cartographer-ros
RUN apt install -y ros-${ROS_DISTRO}-navigation2
RUN apt install -y ros-${ROS_DISTRO}-nav2-bringup
RUN apt install -y ros-${ROS_DISTRO}-dynamixel-sdk
RUN apt install -y ros-${ROS_DISTRO}-turtlebot3-msgs
RUN apt install -y ros-${ROS_DISTRO}-turtlebot3
RUN apt install -y ros-${ROS_DISTRO}-turtlebot3-gazebo

# cria e determina diretório da area de trabalho
RUN mkdir /turtlebot3_ws
WORKDIR /turtlebot3_ws

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
RUN echo "bind C-c run 'tmux save-buffer - | xclip -i -sel clipboard'"                      >> ~/.tmux.conf
RUN echo "bind C-v run 'tmux set-buffer '\$(xclip -o -sel clipboard)'; tmux paste-buffer'"   >> ~/.tmux.conf
