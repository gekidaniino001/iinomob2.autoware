#!/bin/bash

mkdir src
vcs import src < autoware.repos
vcs import src < iino.repos

source /opt/ros/humble/setup.bash
source src/iino.universe/boot_scripts/setup.bash

pushd src/iino.universe/patch
./do_patch.py
popd

sudo rosdep init
sudo rm /etc/ros/rosdep/sources.list.d/20-default.list

rosdep update

rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO

PKG="setuptools"
VER_TGT="59.6.0"
VER_NOW=$( pip show $PKG | grep Version | tr -d ' ' | cut -d : -f2 )
if [ "$VER_NOW" != "$VER_TGT" ]; then
  pip install $PKG==$VER_TGT >/dev/null
fi

### for test
## cat ~/test_patch/d-univ2 | ( cd src/iino.universe ; patch -p1 )

## colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --parallel-works 4
## colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-select autoware_launch
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

pushd src/iino.universe/tool
./inst_wx.py
popd

mkdir -p src/iino.scenario/data_bin
cp -r ~/enkaku src/iino.scenario/data_bin/

$TOOL_DIR/lan_setup.py
$TOOL_DIR/ssd_setup.py
