extends Node2D


var randomize_start_position: bool setget set_randomize_start_position

func set_randomize_start_position(value):
	for children in get_children():
		children.randomize_start_position = value


func _on_ConveyorBelt_cb_speed_changed(old, new):
	for children in get_children():
		children.set_cb_speed(new)

