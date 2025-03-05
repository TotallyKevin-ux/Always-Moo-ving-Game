class_name Cow
extends CharacterBody2D

@onready var timer := $"../Death Timer"
@onready var sliding_time := $Sliding
@onready var can_slide_timer := $Slide
@onready var stamina_bar := $stamina
@onready var hurt_box := $"Hurt Box"
@onready var input_grace_timer := $InputGrace

var can_slide = true
var sliding = false
var slide_vel = Vector2(0,0)

const death_x = 0
const death_y = 0


const MAX_SPEED: int = 500 ## maximum speed in any direction
const ACCEL_VAL: int = 20 ## static acceleration value in any direction
const RESIST_VAL: int = 10 ## static acceleration value for "air resistance" that apply to any direction player is not moving in
enum {UP, DOWN, RIGHT, LEFT}
var input_held = [false,false,false,false] 
var input_grace: bool = false ## if still in grace period (consider second last input)
var cur_vel: Vector2 = Vector2(0,0) ## current movement speed + direction
var cur_accel: Vector2 = Vector2(0,0) ## current acceleration value

func _ready():
	stamina_bar.visible = false


func _physics_process(_delta: float) -> void:
	get_next_velocity()
	if(Input.is_action_pressed("space")):
		sliding_func()
		slide_vel = slide_vel.normalized() * 900
	if sliding == false:
		set_velocity(cur_vel)
		slide_vel = cur_vel
	else:
		set_velocity(slide_vel)

	move_and_slide()

func died():
	position.x = death_x
	position.y = death_y
	timer.start()
	timer.paused = false


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		timer.start()
		timer.paused = false

## gets movement direction
func get_next_velocity() -> Vector2:
	if cur_accel.y == 0:
		if abs(cur_vel.y) <= RESIST_VAL:
			cur_vel.y = 0
		elif cur_vel.y < 0:
			cur_vel.y += RESIST_VAL
		else:
			cur_vel.y -= RESIST_VAL
	if cur_accel.x == 0:
		if abs(cur_vel.x) < RESIST_VAL:
			cur_vel.x = 0
		elif cur_vel.x < 0:
			cur_vel.x += RESIST_VAL
		else:
			cur_vel.x -= RESIST_VAL
	cur_vel.x += cur_accel.x
	cur_vel.y += cur_accel.y
	# clamp vel
	cur_vel = cur_vel.clamp(Vector2(-MAX_SPEED,-MAX_SPEED), Vector2(MAX_SPEED,MAX_SPEED))
	return cur_vel

func _input(event):
	#print(event.as_text())
	if event.is_action_pressed("up"):
		input_held[UP] = true
		cur_accel.y = -ACCEL_VAL
	elif event.is_action_released("up"):
		if not input_grace and not x_input_held():
			cur_accel.x = 0
		update_on_release(UP)
	elif event.is_action_pressed("down"):
		input_held[DOWN] = true
		cur_accel.y = ACCEL_VAL
	elif event.is_action_released("down"):
		if not input_grace and not x_input_held():
			cur_accel.x = 0
		update_on_release(DOWN)
	elif event.is_action_pressed("left"):
		input_held[LEFT] = true
		cur_accel.x = -ACCEL_VAL
	elif event.is_action_released("left"):
		if not input_grace and not y_input_held():
			cur_accel.y = 0
		update_on_release(LEFT)
	elif event.is_action_pressed("right"):
		input_held[RIGHT] = true
		cur_accel.x = ACCEL_VAL
	elif event.is_action_released("right"):
		if not input_grace and not y_input_held():
			cur_accel.y = 0
		update_on_release(RIGHT)

# remember the last and second last released input
func update_on_release(input):
	input_held[input] = false
	input_grace_timer.start(0.1)
	input_grace = true

func x_input_held() -> bool:
	return input_held[LEFT] or input_held[RIGHT]

func y_input_held() -> bool:
	return input_held[UP] or input_held[DOWN]

func _on_death_timer_timeout() -> void:
	print("now") 
	timer.paused = true

func sliding_func(): 
	if can_slide == true:
		print("2")
		can_slide = false
		hurt_box.process_mode = Node.PROCESS_MODE_DISABLED
		sliding = true
		stamina_bar.visible = true
		stamina_bar.init_stamina(0)
		can_slide_timer.start()
		can_slide_timer.paused = false
		sliding_time.start()
		sliding_time.paused = false

func _on_sliding_timeout() -> void:
	sliding_time.paused = true
	hurt_box.process_mode = Node.PROCESS_MODE_PAUSABLE
	sliding = false

func _on_slide_timeout() -> void:
	can_slide_timer.paused = true
	can_slide = true
	stamina_bar.visible = false


func _on_mov_grace_timeout() -> void:
	input_grace_timer.stop()
	input_grace = false
	if true in input_held:
		if not x_input_held():
			cur_accel.x = 0
		if not y_input_held():
			cur_accel.y = 0
