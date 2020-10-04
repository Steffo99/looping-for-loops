extends Node2D
class_name GameButton

export(Color, RGB) var color: Color = Color.white setget set_color
export(Texture) var active_sprite: Texture = null
export(Texture) var pressed_sprite: Texture = null
export(bool) var is_active: bool = true setget set_active


signal clicked


func _ready():
	set_color(color)
	set_active(is_active)


func set_color(value):
	color = value
	$Sprite.modulate = value

func set_active(value):
	is_active = value
	if value:
		$Sprite.texture = active_sprite
	else:
		$Sprite.texture = pressed_sprite


func _on_GameButton_input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if is_active and event.is_pressed():
		emit_signal("clicked")
