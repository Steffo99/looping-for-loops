extends Node2D
class_name GameButton

export(Color, RGB) var color: Color = Color.white setget set_color
export(Texture) var icon: Texture = null setget set_icon
export(bool) var is_active: bool = true setget set_active


var active_sprite: Texture = preload("res://Sprites/button.png")
var pressed_sprite: Texture = preload("res://Sprites/button_pressed.png")


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

func activate():
	set_active(true)
	
func deactivate():
	set_active(false)

func toggle():
	set_active(not is_active)


func set_icon(value):
	icon = value
	$Icon.texture = value


func _on_GameButton_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):
	if is_active and event.is_pressed():
		emit_signal("clicked")


func _on_GameButton_clicked():
	deactivate()
