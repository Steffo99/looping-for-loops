extends KinematicBody2D
class_name ExtendedKinematicBody2D


func get_floor():
	for slide in get_slide_count():
		var collision = get_slide_collision(slide)
		if collision.normal != get_floor_normal():
			continue
		return collision.collider
