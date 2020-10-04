extends Node
class_name ScrollParent


export(Vector2) var scroll_velocity: Vector2 = Vector2(-100, 0)
var parent = null


func _enter_tree():
	parent = get_parent()


func _physics_process(delta):
	parent.position += scroll_velocity * delta
