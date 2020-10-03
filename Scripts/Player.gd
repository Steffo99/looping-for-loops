extends ExtendedKinematicBody2D
class_name Player

export(Vector2) var gravity: Vector2
var speed: Vector2 = Vector2.ZERO

export(float) var move_speed: float
export(float) var jump_speed: float
export(float) var jump_buffer_msec: float

var can_jump = false
var jump_buffer = 0


func _physics_process(delta):
	var up_normal = -gravity.normalized()
	var floor_normal = get_floor_normal()
	
	if is_on_floor():
		var gravity_speed = speed * up_normal
		speed -= gravity_speed * floor_normal
		can_jump = true
	
	speed += gravity
	
	var current_time = OS.get_ticks_msec()
	
	if Input.is_action_just_pressed("plr_up"):
		jump_buffer = current_time
	
	if can_jump and current_time - jump_buffer <= jump_buffer_msec:
		speed += up_normal * jump_speed
		can_jump = false
	
	var movement = speed
	
	if is_on_floor():
		var current_floor = get_floor()
		if current_floor.has_method("get_conveyor_speed"):
			movement += floor_normal.rotated(- PI / 2) * current_floor.get_conveyor_speed(position)
	
	if Input.is_action_pressed("plr_left"):
		movement += Vector2.LEFT * move_speed
	if Input.is_action_pressed("plr_right"):
		movement += Vector2.RIGHT * move_speed
	
	move_and_slide(movement, up_normal)
