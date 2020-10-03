extends StaticBody2D
class_name Press


var root_node: Node = null
var conductor: Conductor = null


func _subbeat(subbeat_num):
	if subbeat_num % 24 == 0:
		$AnimationPlayer.play("Stomp")
	elif subbeat_num % 24 == 12:
		$AnimationPlayer.play_backwards("Stomp")

func _enter_tree():
	root_node = get_tree().current_scene
	conductor = root_node.get_node("Conductor")
	conductor.connect("subbeat", self, "_subbeat")


func _on_StompArea_body_entered(body):
	print(body)
