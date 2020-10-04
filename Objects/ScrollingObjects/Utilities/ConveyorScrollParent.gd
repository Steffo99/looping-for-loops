extends ScrollParent
class_name ConveyorScrollParent


var conveyor_belt: ConveyorBelt = null


func _ready():
	conveyor_belt = get_tree().current_scene.get_node("ConveyorBelt")
	_on_ConveyorBelt_cb_speed_changed(0, conveyor_belt.cb_speed)
	conveyor_belt.connect("cb_speed_changed", self, "_on_ConveyorBelt_cb_speed_changed")

func _on_ConveyorBelt_cb_speed_changed(old, new):
	scroll_velocity.x = -new
