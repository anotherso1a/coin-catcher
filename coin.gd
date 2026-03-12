extends Node2D
class_name Coin

signal coin_collected

const SPEED = 200

func _process(delta):
	position.y += SPEED * delta
	
	# 超出屏幕下方就销毁
	if position.y > 650:
		queue_free()

func _on_area_entered(area):
	if area.name == "Player":
		coin_collected.emit()
		queue_free()
