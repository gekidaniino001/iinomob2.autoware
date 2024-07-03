### install
```
git clone https://github.com/gekidaniino001/iino.universe.git
cd iinomob2.autoware
mkdir src
vcs import src < autoware.repos
vcs import src < iino.repos 
source /opt/ros/humble/setup.bash
rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
```
### update
```
vcs pull src
```
