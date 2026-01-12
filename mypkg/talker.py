# SPDX-FileCopyrightText: 2025 Kanta Hirazawa
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int16

class Talker(Node):
    def __init__(self):
        super().__init__('talker')
        self.pub = self.create_publisher(Int16, 'battery', 10)
        self.create_timer(1.0, self.cb)
    def cb(self):
        msg = Int16()
        try:
            with open('/sys/class/power_supply/BAT0/capacity', 'r') as f:
                msg.data = int(f.read().strip())
        except FileNotFoundError:
            self.get_logger().warn("Battery info not found. Sending dummy value.")
            msg.data = 0
        except Exception as e:
            self.get_logger().error(f"Error reading battery: {e}")
            msg.data = -1

def main():
    rclpy.init()
    node = Talker()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
