# CPU負荷計測
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
```
### 個別に実行
端末１
```bash
ros2 run mypkg cpu_load
```
端末２
```bash
ros2 run mypkg cpu_view
```

## トピックからの出力例
端末で ros2 topic echo を使用した場合の出力例です。（例：負荷平均が 0.06 の場合、6 という値が出力されます）
```bash
$ ros2 topic echo /load_avg
data: 6
---
data: 5
---
data: 5
---
```

## ライセンス
* このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
* このパッケージのコードの一部は、下記のスライド (CC-BY-SA 4.0 by Ryuichi Ueda) のものを、本人の許可を得て自身の著作としたものです。　
  * [ryuichiueda/slides_marp/robosys_2025](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2025)
* © 2025 Kanta Hirazawa
