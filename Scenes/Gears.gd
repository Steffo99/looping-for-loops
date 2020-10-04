extends Node2D


var cb_speed: float setget set_cb_speed, get_cb_speed

func set_cb_speed(value):
	for children in get_children():
		children.set_cb_speed(value)

func get_cb_speed():
	return cb_speed


var randomize_start_position: bool setget set_randomize_start_position

func set_randomize_start_position(value):
	for children in get_children():
		children.randomize_start_position = value
