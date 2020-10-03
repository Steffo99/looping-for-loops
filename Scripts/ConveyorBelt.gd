extends StaticBody2D
class_name ConveyorBelt


# Speed (and direction) of the conveyor belt
export(float) var conveyor_speed = 0


func get_conveyor_speed(other_pos: Vector2):
	var relative_position = other_pos - position
	var speed_sign = sign(relative_position.dot(Vector2.UP.rotated(rotation)))
	return speed_sign * conveyor_speed
