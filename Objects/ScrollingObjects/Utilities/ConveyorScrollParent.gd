extends ScrollParent
class_name ConveyorScrollParent


onready var conveyor_belt: ConveyorBelt = null


func _enter_tree():
	conveyor_belt = get_tree().current_scene.get_node("ConveyorBelt")
	conveyor_belt.connect("cb_speed_changed", self, "_on_ConveyorBelt_cb_speed_changed")

func _on_ConveyorBelt_cb_speed_changed(old, new):
	scroll_velocity.x = -conveyor_belt.get_relative_cb_speed(parent.position)
