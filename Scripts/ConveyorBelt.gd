extends StaticBody2D
class_name ConveyorBelt


# Speed (and direction) of the conveyor belt
export(float) var cb_speed = 100 setget set_cb_speed, get_cb_speed
export(bool) var randomize_gear_starting_position = false

func set_cb_speed(value):
	cb_speed = value
	$Gears.set_cb_speed(value)

func get_cb_speed():
	return cb_speed


func _ready():
	$Gears.set_randomize_start_position(randomize_gear_starting_position)
	$Gears.set_cb_speed(cb_speed)


func get_relative_cb_speed(other_pos: Vector2):
	var relative_position = other_pos - position
	var speed_sign = sign(relative_position.dot(Vector2.UP.rotated(rotation)))
	return speed_sign * cb_speed
