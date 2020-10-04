extends Area2D
class_name ScrollingArea


export(Vector2) var scroll_velocity: Vector2 = Vector2(-100, 0)


func _physics_process(delta):
	position += scroll_velocity * delta
