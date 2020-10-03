extends ExtendedKinematicBody2D
class_name ScrollingBlock


export(Vector2) var scroll_velocity: Vector2 = Vector2(-10, 0)


func _physics_process(delta):
	# FIXME: This doesn't really work... Any other things we could try?
	var collision = move_and_collide(scroll_velocity * delta)
	if collision:
		print(collision)
