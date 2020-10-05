extends Area2D
class_name Buzzsaw


func _ready():
	$AnimationPlayer.play("SpinClockwise")


func _on_Buzzsaw_body_entered(body):
	body.die()
