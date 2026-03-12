extends Node

# 游戏主脚本 - 接金币游戏

var score = 0
var lives = 3
var game_over = false

# 节点引用
@onready var player = $Player
@onready var score_label = $CanvasLayer/ScoreLabel
@onready var lives_label = $CanvasLayer/LivesLabel
@onready var game_over_label = $CanvasLayer/GameOverLabel
@onready var coin_spawn_timer = $CoinSpawnTimer

# 预加载
var coin_scene = preload("res://coin.tscn")
var bomb_scene = preload("res://bomb.tscn")

func _ready():
	# 连接信号
	player.player_hit.connect(_on_player_hit)
	coin_spawn_timer.timeout.connect(_spawn_coin_or_bomb)
	
	# 启动生成计时器
	coin_spawn_timer.start(1.0)
	
	update_ui()

func _process(delta):
	if game_over:
		if Input.is_action_just_pressed("ui_accept"):
			restart_game()
		return
	
	# 玩家移动
	var direction = Input.get_axis("ui_left", "ui_right")
	player.move(direction, delta)

func _spawn_coin_or_bomb():
	if game_over:
		return
	
	# 70% 金币，30% 炸弹
	if randf() < 0.7:
		var coin = coin_scene.instantiate()
		coin.position = Vector2(randf_range(50, 550), -20)
		coin.coin_collected.connect(_on_coin_collected)
		add_child(coin)
	else:
		var bomb = bomb_scene.instantiate()
		bomb.position = Vector2(randf_range(50, 550), -20)
		bomb.bomb_exploded.connect(_on_bomb_exploded)
		add_child(bomb)

func _on_coin_collected():
	score += 10
	update_ui()

func _on_bomb_exploded():
	lives -= 1
	update_ui()
	
	# 屏幕震动效果
	var tween = create_tween()
	for i in range(5):
		tween.tween_property(get_viewport(), "canvas_position", Vector2(5, 5), 0.05)
		tween.tween_property(get_viewport(), "canvas_position", Vector2(-5, -5), 0.05)
	tween.tween_property(get_viewport(), "canvas_position", Vector2.ZERO, 0.05)
	
	if lives <= 0:
		end_game()

func _on_player_hit():
	lives -= 1
	update_ui()
	if lives <= 0:
		end_game()

func end_game():
	game_over = true
	game_over_label.visible = true
	game_over_label.text = "GAME OVER!\nScore: %d\nPress Enter to Restart" % score
	coin_spawn_timer.stop()

func restart_game():
	game_over = false
	score = 0
	lives = 3
	game_over_label.visible = false
	
	# 清除所有金币和炸弹
	for child in get_children():
		if child.is_in_group("collectibles"):
			child.queue_free()
	
	update_ui()
	coin_spawn_timer.start()

func update_ui():
	score_label.text = "Score: %d" % score
	lives_label.text = "Lives: %s" % "❤️" * lives
