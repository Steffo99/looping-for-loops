extends ExtendedKinematicBody2D
class_name Player

export(Vector2) var gravity: Vector2 = Vector2(0, 10)
var speed: Vector2 = Vector2.ZERO

export(float) var move_speed: float = 300
export(float) var jump_speed: float = 425
export(float) var jump_buffer_msec: float = 80
export(float) var quick_fall_gravity_multiplier: float = 4
export(bool) var stop_jump_on_bonk: bool = true

var can_jump: bool = false
var jump_buffer: int = 0

var is_quick_falling: bool = false
var quick_fall_buffer: int = 0

func up_normal():
	return -gravity.normalized()

func _physics_process(delta):
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
