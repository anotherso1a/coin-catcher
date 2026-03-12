extends Node2D
class_name Bomb

signal bomb_exploded

const SPEED = 250

func _process(delta):
	position.y += SPEED * delta
	
	if position.y > 650:
		queue_free()

func _on_area_entered(area):
	if area.name == "Player":
		bomb_exploded.emit()
		queue_free()
