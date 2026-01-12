#!/bin/bash
# SPDX-FileCopyrightText: 2025 Kanta Hirazawa
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
#source $dir/.bashrc
source install/setup.bash

timeout 10 ros2 launch mypkg talk_listen.launch.py > /tmp/mypkg.log

cat /tmp/mypkg.log | grep 'Received Battery Level'
#grep 'Listen: 10'
