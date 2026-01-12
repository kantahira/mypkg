#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Kanta Hirazawa
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int16

class Listener(Node):
    def __init__(self):
        super().__init__('listener')
        self.create_subscription(Int16, 'load_avg', self.cb, 10)

    def cb(self, msg):
        actual_load = msg.data / 100.0
        self.get_logger().info(f'Current CPU Load: {actual_load}')

def main():
    rclpy.init()
    node = Listener()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
