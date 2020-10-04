extends StaticBody2D
class_name ConveyorBelt


# Speed (and direction) of the conveyor belt
export(float) var cb_speed: float = 100 setget set_cb_speed, get_cb_speed
export(bool) var randomize_gear_starting_position: bool = false

signal cb_speed_changed(old, new)

func set_cb_speed(value):
	var old = cb_speed
	cb_speed = value
	emit_signal("cb_speed_changed", old, value)

func get_cb_speed():
	return cb_speed

func get_relative_cb_speed(other_pos: Vector2):
	var relative_position = other_pos - position
	var speed_sign = sign(relative_position.dot(Vector2.UP.rotated(rotation)))
	return speed_sign * cb_speed
