### install
```
cd iinomob2.autoware
mkdir src
vcs import src < autoware.repos
vcs import src < iino.repos 
source /opt/ros/humble/setup.bash
rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
ccb
```
### update
```
vcs pull src
```
