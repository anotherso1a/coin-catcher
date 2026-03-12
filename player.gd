extends Area2D
class_name Player

signal player_hit

const SPEED = 400
const SCREEN_WIDTH = 600

func _ready():
	position = Vector2(300, 500)
	area_entered.connect(_on_area_entered)

func move(direction: float, delta: float):
	position.x += direction * SPEED * delta
	position.x = clamp(position.x, 30, SCREEN_WIDTH - 30)

func _on_area_entered(area):
	if area.is_in_group("bomb"):
		player_hit.emit()
		area.queue_free()
