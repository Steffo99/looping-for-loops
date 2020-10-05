extends Node2D
class_name GhostBlock

var active_sprite: Texture = preload("res://Sprites/block_ON.png")
var inactive_sprite: Texture = preload("res://Sprites/block_OFF.png")
export(bool) var is_active: bool = true setget set_active


func _ready():
	set_active(is_active)


func set_active(value):
	is_active = value
	$CollisionShape2D.disabled = not value
	if value:
		$Sprite.texture = active_sprite
	else:
		$Sprite.texture = inactive_sprite


func activate():
	set_active(true)
	
func deactivate():
	set_active(false)

func toggle():
	set_active(not is_active)
