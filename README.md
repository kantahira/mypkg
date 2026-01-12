# mypkg
システムのCPU負荷を確認するするためのROS 2パッケージです。

[![test](https://github.com/kantahira/mypkg/actions/workflows/test.yml/badge.svg)](https://github.com/kantahira/mypkg/actions/workflows/test.yml)

## ノード
### cpu_load
システムの `/proc/loadavg` からCPU負荷の平均値（1分間平均）を取得し、トピックとして配信するノードです。

* **パブリッシュするトピック**
    * `load_avg` (`std_msgs/msg/Int16`)
        * 現在のロードアベレージを100倍した整数値。
        * （Int16型を利用するため、小数を整数に変換して送信しています）

### cpu_view
`cpu_load` ノードからデータを受け取り、人間が読みやすい形式（小数）に戻してログに表示する確認用ノードです。

* **サブスクライブするトピック**
    * `load_avg` (`std_msgs/msg/Int16`)

## 実行方法
### Launchファイルによる実行
`cpu_load` と `cpu_view` を同時に起動します。
```bash
ros2 launch mypkg cpu_monitor.launch.py
