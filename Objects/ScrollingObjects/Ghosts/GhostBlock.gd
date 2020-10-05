extends KinematicBody2D
class_name GhostBlock

export(bool) var is_active: bool = true setget set_active


func _ready():
	set_active_no_anim(is_active)


func set_active_no_anim(value):
	$CollisionShape2D.disabled = not value
	is_active = value


func set_active(value):
	if not is_active and value:
		$AnimationPlayer.play("Appear")
	elif is_active and not value:
		$AnimationPlayer.play_backwards("Appear")
	set_active_no_anim(value)


func activate():
	set_active(true)
	
func deactivate():
	set_active(false)

func toggle():
	set_active(not is_active)
