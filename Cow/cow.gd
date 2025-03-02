class_name Cow
extends CharacterBody2D

const SPEED: int = 200 #px/s
var direction: Vector2 = Vector2(0,0) ## current movement direction

func _physics_process(delta: float) -> void:
	direction = get_direction()
	set_velocity(SPEED * direction)
	move_and_slide()

## gets movement direction
func get_direction() -> Vector2:
	var res: Vector2 = Vector2.ZERO
	if(Input.is_action_pressed("up")):
		res.y += -1
	if(Input.is_action_pressed("left")):
		res.x += -1
	if(Input.is_action_pressed("down")):
		res.y += 1
	if(Input.is_action_pressed("right")):
		res.x += 1
	if(res == Vector2.ZERO):
		return direction
	return res.normalized()
