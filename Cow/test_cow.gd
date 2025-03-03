class_name Test_Cow
extends CharacterBody2D

const MAX_SPEED: int = 500 ## maximum speed in any direction
const ACCEL_TIME: float = .5 ## static acceleration time in any direction
const RESIST_VAL: int = 10 ## static acceleration value for "air resistance" that apply to any direction player is not moving in
var last_input_is_x: bool = false
var cur_vel: Vector2 = Vector2(0,0) ## current movement speed + direction
var cur_accel: Vector2 = Vector2(0,0) ## current acceleration value
var direction: Vector2 = Vector2(0,0)


func _physics_process(delta: float) -> void:
	direction  = get_direction()
	cur_vel = get_next_velocity(delta)
	set_velocity(cur_vel)
	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		print("hi")
	else:
		print("broken")

## gets movement directionaa
func get_next_velocity(delta: float) -> Vector2:
	var res := Vector2.ZERO
	cur_accel = Vector2(MAX_SPEED / ACCEL_TIME,MAX_SPEED / ACCEL_TIME) # messed up a little trying to fix diagonal only
	res.x = move_toward(velocity.x, MAX_SPEED * direction.x, cur_accel.x * delta)
	res.y = move_toward(velocity.y, MAX_SPEED * direction.y, cur_accel.y * delta)
	return res

## Remake of earlier get_girection() function
func get_direction() -> Vector2:
	var res := Vector2.ZERO
	if(Input.is_action_pressed("up")):
		res.y += -1
	if(Input.is_action_pressed("down")):
		res.y += 1
	if(Input.is_action_pressed("right")):
		res.x += 1
	if(Input.is_action_pressed("left")):
		res.x += -1
	if(res == Vector2.ZERO):
		res = velocity # Should be direction instead of velocity if we'll include grace time or smth like that
	return res.normalized()
