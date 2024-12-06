#!/bin/bash

mkdir src
vcs import src < autoware.repos
vcs import src < iino.repos

source /opt/ros/humble/setup.bash
source src/iino.universe/boot_scripts/setup.bash

sudo rosdep init
sudo rm /etc/ros/rosdep/sources.list.d/20-default.list

rosdep update

rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO

colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
