extends Node2D


var cb_speed: float setget set_cb_speed, get_cb_speed
var randomize_start_position: bool = false

func set_cb_speed(value):
	cb_speed = value
	$AnimationPlayer.playback_speed = -value / 80
	$AnimationPlayer.play("SpinClockwise")
	if randomize_start_position:
		var offset = GLOBAL.rng.randf_range(0.0, 1.0)
		$AnimationPlayer.seek(offset, true)
		randomize_start_position = false

func get_cb_speed():
	return cb_speed

