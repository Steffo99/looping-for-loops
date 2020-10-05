extends Node2D
class_name Clock


var conveyor_belt: ConveyorBelt = null
var wrapper: Wrapper = null
var current_position: float = 0


func _ready():
	conveyor_belt = get_tree().current_scene.get_node("ConveyorBelt")
	wrapper = get_tree().current_scene.get_node("Wrapper")
	_on_ConveyorBelt_cb_speed_changed(0, conveyor_belt.cb_speed)
	conveyor_belt.connect("cb_speed_changed", self, "_on_ConveyorBelt_cb_speed_changed")

func _physics_process(delta):
	current_position += delta * conveyor_belt.cb_speed
	$Hand.rotation =  int(current_position) % int(wrapper.total_length) / wrapper.total_length * TAU

func _on_ConveyorBelt_cb_speed_changed(old, new):
	$AnimationPlayer.playback_speed = new / 400
	$AnimationPlayer.play("SpinCCW")
