#!/bin/bash
# SPDX-FileCopyrightText: 2025 Kanta Hirazawa
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source $dir/ros2_ws/install/setup.bash

ros2 launch mypkg talk_listen.launch.py > /dev/null 2>&1 &
PID=$!

sleep 5

timeout 15 ros2 topic echo /load_avg > /tmp/mypkg_log.txt

kill $PID

if grep -q "data:" /tmp/mypkg_log.txt; then
    echo "Test Passed: Topic /load_avg is active!"
    exit 0
else
    echo "Test Failed: Topic /load_avg not received."
    cat /tmp/mypkg_log.txt
    exit 1
fi
