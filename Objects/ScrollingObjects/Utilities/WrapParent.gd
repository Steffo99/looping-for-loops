extends Node2D
class_name WrapParent


onready var parent: Node2D = get_parent()
onready var wrapper: Wrapper = get_tree().current_scene.get_node("Wrapper")
onready var absolute_position: Vector2 = parent.position


func _physics_process(_delta):
	if global_position.x <= 0:
		parent.position.x += wrapper.total_length
