extends GameButton
class_name CBSpeedChangeButton

export(float) var change: float = -30
var conveyor_belt: ConveyorBelt = null


func _ready():
	conveyor_belt = get_tree().current_scene.get_node("ConveyorBelt")


func _on_GameButton_clicked():
	._on_GameButton_clicked()
	conveyor_belt.cb_speed += change
