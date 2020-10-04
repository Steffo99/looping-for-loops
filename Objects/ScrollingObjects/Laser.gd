extends Node2D


export(bool) var is_active: bool = true setget set_active


func _ready():
	set_active(is_active)


func set_active(value):
	is_active = value
	$Beam.visible = value
	$Beam/RecreatingRectangleShape.disabled = not value

func activate():
	set_active(true)
	
func deactivate():
	set_active(false)

func toggle():
	set_active(not is_active)

func _physics_process(delta):
	var point: Vector2 = $Beam/Raycast.get_collision_point()
	var length = (point - global_position).y
	$Beam/Continuous.scale.y = length / 40
	$Beam/End.global_position = point
	$Beam/RecreatingRectangleShape.shape.extents.y = (length / 2) + 10
	$Beam/RecreatingRectangleShape.position.y = (length / 2) - 5
