# Coin Catcher - 接金币游戏

## 快速开始

1. 用 Godot 打开 `~/godot-projects/coin_catcher` 项目
2. 按以下步骤创建场景：

### 创建主场景 (main.tscn)

1. 创建 2D 场景，根节点改名为 "Main"
2. 添加以下子节点：
   - **Player** (CharacterBody2D)
     - 添加 CollisionShape2D (圆形，半径 25)
     - 添加 Sprite2D (画个蓝色圆形或用图标)
     - 挂载 `player.gd` 脚本
   - **UI** (CanvasLayer)
     - **ScoreLabel** (Label) - 位置 (20, 20)
     - **LivesLabel** (Label) - 位置 (20, 50)
     - **GameOverLabel** (Label) - 位置 (200, 250)，默认隐藏
   - **CoinSpawnTimer** (Timer) - wait_time=1.0, autostart=true
3. 挂载 `main.gd` 到 Main 节点

### 创建金币场景 (coin.tscn)

1. 创建 2D 场景，根节点改名为 "Coin"
2. 添加：
   - **Area2D** (分组为 "collectibles")
     - **CollisionShape2D** (圆形，半径 15)
     - **Sprite2D** (画个金色圆形)
3. 挂载 `coin.gd` 脚本

### 创建炸弹场景 (bomb.tscn)

1. 创建 2D 场景，根节点改名为 "Bomb"
2. 添加：
   - **Area2D** (分组为 "bomb", "collectibles")
     - **CollisionShape2D** (圆形，半径 20)
     - **Sprite2D** (画个红色圆形)
3. 挂载 `bomb.gd` 脚本

## 操作说明

- **← →** 或 **A D** 左右移动
- 接到金币 +10 分
- 碰到炸弹 -1 条命
- 3 条命用完游戏结束，回车重开

## 玩法

控制底部玩家左右移动，接住下落的金币，躲避炸弹！
