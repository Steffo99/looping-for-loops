extends Panel
class_name LoopCountPanel



func _on_Player_loop_collected(loops):
	$LoopCountLabel.text = "%d" % loops
