extends ScrollingBlock
class_name Press

export(int, 0, 47) var subbeat_offset = 0

var root_node: Node = null
var conductor: Conductor = null


func _subbeat(subbeat_num):
	if (subbeat_num - subbeat_offset) % 48 == 0:
		$AnimationPlayer.play("Stomp")
	elif (subbeat_num - subbeat_offset) % 48 == 24:
		$AnimationPlayer.play_backwards("Stomp")

func _enter_tree():
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.extents = Vector2(80, 76.5)
	$Bottom/StompArea/CollisionShape2D.shape = RectangleShape2D.new()
	$Bottom/StompArea/CollisionShape2D.shape.extents = Vector2(78, 4)
	root_node = get_tree().current_scene
	conductor = root_node.get_node("Conductor")
	conductor.connect("subbeat", self, "_subbeat")

func _on_StompArea_body_entered(body):
	print(body)
