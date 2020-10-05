extends KinematicBody2D
class_name Player

var rng = RandomNumberGenerator.new()


export(Vector2) var gravity: Vector2 = Vector2(0, 10)
export(float) var move_speed: float = 300
export(float) var jump_speed: float = 425
export(float) var jump_buffer_msec: float = 80
export(float) var quick_fall_gravity_multiplier: float = 4
export(bool) var stop_jump_on_bonk: bool = true

var speed: Vector2 = Vector2.ZERO
var can_jump: bool = false
var jump_buffer: int = 0
var is_quick_falling: bool = false
var quick_fall_buffer: int = 0

signal loop_collected(loops)
var loops_collected: int = 0

func get_floor():
	for slide in get_slide_count():
		var collision = get_slide_collision(slide)
		if collision.normal != get_floor_normal():
			continue
		return collision.collider


func _ready():
	$Donut.self_modulate = Color.from_hsv(rng.randf_range(0.0, 1.0), 0.4, 1)
	emit_signal("loop_collected", loops_collected)

func up_normal():
	return -gravity.normalized()

func _process(delta):
	var actual_speed = speed.y - gravity.y
	if Input.is_action_pressed("plr_left"):
		if actual_speed < 0:
			$Body.animation = "up_left"
			$Donut.animation = "up"
			$Legs.animation = "up_left"
		elif actual_speed > 0:
			$Body.animation = "down_left"
			$Donut.animation = "down"
			$Legs.animation = "down_left"
		else:
			$Body.animation = "neutral_left"
			$Donut.animation = "neutral"
			$Legs.animation = "neutral_left"
	elif Input.is_action_pressed("plr_right"):
		if actual_speed < 0:
			$Body.animation = "up_right"
			$Donut.animation = "up"
			$Legs.animation = "up_right"
		elif actual_speed > 0:
			$Body.animation = "down_right"
			$Donut.animation = "down"
			$Legs.animation = "down_right"
		else:
			$Body.animation = "neutral_right"
			$Donut.animation = "neutral"
			$Legs.animation = "neutral_right"
	else:
		if actual_speed < 0:
			$Body.animation = "up"
			$Donut.animation = "up"
			$Legs.animation = "up"
		elif actual_speed > 0:
			$Body.animation = "down"
			$Donut.animation = "down"
			$Legs.animation = "down"
		else:
			$Body.animation = "neutral"
			$Donut.animation = "neutral"
			$Legs.animation = "neutral"


func _physics_process(_delta):
	var up_normal = up_normal()
	var floor_normal = get_floor_normal()
	
	if is_on_floor():
		var gravity_speed = speed * up_normal
		speed -= gravity_speed * floor_normal
		can_jump = true
		is_quick_falling = false
	
	if stop_jump_on_bonk and is_on_ceiling():
		speed.y = 0
	
	if is_quick_falling:
		speed += gravity * quick_fall_gravity_multiplier
	else:
		speed += gravity
	
	var current_time = OS.get_ticks_msec()
	
	if Input.is_action_just_pressed("plr_up"):
		jump_buffer = current_time
	
	if Input.is_action_just_released("plr_up"):
		quick_fall_buffer = OS.get_ticks_msec()
	
	if can_jump and current_time - jump_buffer <= jump_buffer_msec:
		speed += up_normal * jump_speed
		can_jump = false
	
	if quick_fall_buffer > jump_buffer:
		 is_quick_falling = true
	
	var movement = speed
	
	if is_on_floor():
		var current_floor = get_floor()
		if current_floor.has_method("get_relative_cb_speed"):
			movement += floor_normal.rotated(- PI / 2) * current_floor.get_relative_cb_speed(position)
	
	if Input.is_action_pressed("plr_left"):
		movement += Vector2.LEFT * move_speed
	if Input.is_action_pressed("plr_right"):
		movement += Vector2.RIGHT * move_speed
	
	move_and_slide(movement, up_normal)


func win():
	print("YOU WIN!")
	print("You collected %s loops." % loops_collected)
	$FadeTo/AnimationPlayer.play("FadeToWhite")

func die():
	print("YOU DIED")
	print("You collected %s loops." % loops_collected)
	$Body.visible = false
	$Donut.visible = false
	$Legs.visible = false
	$FadeTo/AnimationPlayer.play("FadeToBlack")


func _on_WinDoor_body_entered(body):
	win()


func _on_Area2D_body_entered(body):
	die()


func _on_AnimationPlayer_animation_finished(anim_name):
	GLOBAL.loops_collected = loops_collected
	if anim_name == "FadeToWhite":
		get_tree().change_scene("res://Objects/Win.tscn")
	elif anim_name == "FadeToBlack":
		get_tree().change_scene("res://Objects/Lose.tscn")
