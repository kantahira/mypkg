#!/bin/bash
# SPDX-FileCopyrightText: 2025 Kanta Hirazawa
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

if [ -f /opt/ros/jazzy/setup.bash ]; then
    source /opt/ros/jazzy/setup.bash
elif [ -f /opt/ros/humble/setup.bash ]; then
    source /opt/ros/humble/setup.bash
fi

cd $dir/ros2_ws
colcon build
#source $dir/.bashrc
source install/setup.bash

#timeout 10 ros2 launch mypkg talk_listen.launch.py > /tmp/mypkg.log

timeout 10 ros2 launch mypkg talk_listen.launch.py > /tmp/mypkg.log 2>&1

cat /tmp/mypkg.log

cat /tmp/mypkg.log | grep 'Received Battery Level'
#grep 'Listen: 10'
