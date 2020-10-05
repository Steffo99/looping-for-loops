extends Area2D
class_name Loop

var rng = RandomNumberGenerator.new()


signal picked_up


func _ready():
	rng.randomize()
	$Sprite.self_modulate = Color.from_hsv(rng.randf_range(0.0, 1.0), 0.4, 1)


func _on_Loop_body_entered(body):
	emit_signal("picked_up")
	body.loops_collected += 1
	$AnimationPlayer.play("pop fade out")
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()


