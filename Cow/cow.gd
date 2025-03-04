class_name Cow
extends CharacterBody2D

<<<<<<< Updated upstream
@onready var timer = $"../Timer"

=======
const death_x = 0
const death_y = 0
var can_slide = true
var sliding = false

@onready var timer = $"../Death Timer"
@onready var stamina_bar := $ProgressBar
@onready var can_slide_timer := $Slide
@onready var hurt_box := $"Hurt Box"
@onready var sliding_timer := $Sliding

>>>>>>> Stashed changes
const MAX_SPEED: int = 500 ## maximum speed in any direction
const ACCEL_VAL: int = 20 ## static acceleration value in any direction
const RESIST_VAL: int = 10 ## static acceleration value for "air resistance" that apply to any direction player is not moving in
const death_x = 0
const death_y = 0

var last_input_is_x: bool = false
var cur_vel: Vector2 = Vector2(0,0) ## current movement speed + direction
var cur_accel: Vector2 = Vector2(0,0) ## current acceleration value

func _ready() -> void:
	stamina_bar.visible = false

func _physics_process(delta: float) -> void:
	get_next_velocity()
	if(Input.is_action_pressed("space")):
		if can_slide == true:
			slide()
	
	if sliding == false:
		set_velocity(cur_vel)
	move_and_slide()

<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
func died():
	position.x = death_x
	position.y = death_y
	timer.start()
	timer.paused = false

<<<<<<< Updated upstream


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		died()
=======
func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		timer.start()
		timer.paused = false
>>>>>>> Stashed changes

## gets movement direction
func get_next_velocity() -> Vector2:
	if(Input.is_action_pressed("up")):
		cur_accel.y = -ACCEL_VAL
		cur_accel.x = 0
		last_input_is_x = false
	elif(Input.is_action_pressed("down")):
		cur_accel.y = ACCEL_VAL
		cur_accel.x = 0
		last_input_is_x = false
	elif(Input.is_action_pressed("right")):
		cur_accel.x = ACCEL_VAL
		cur_accel.y = 0
		last_input_is_x = true
	elif(Input.is_action_pressed("left")):
		cur_accel.x = -ACCEL_VAL
		cur_accel.y = 0
		last_input_is_x = true
	if last_input_is_x:
		if abs(cur_vel.y) <= RESIST_VAL:
			cur_vel.y = 0
		elif cur_vel.y < 0:
			cur_vel.y += RESIST_VAL
		else:
			cur_vel.y -= RESIST_VAL
		cur_vel.x += cur_accel.x
	else:
		if abs(cur_vel.x) < RESIST_VAL:
			cur_vel.x = 0
		elif cur_vel.x < 0:
			cur_vel.x += RESIST_VAL
		else:
			cur_vel.x -= RESIST_VAL
		cur_vel.y += cur_accel.y
	# clamp vel
	cur_vel = cur_vel.clamp(Vector2(-MAX_SPEED,-MAX_SPEED), Vector2(MAX_SPEED,MAX_SPEED))
	return cur_vel


func slide():
	if can_slide == true:
		#slide animation goes here
		sliding = true
		can_slide = false
		stamina_bar.visible = true
		stamina_bar.init_stamina(0)
		hurt_box.process_mode = Node.PROCESS_MODE_DISABLED #might be broken, fix later
		can_slide_timer.start()
		can_slide_timer.paused = false
		sliding_timer.start()
		sliding_timer.paused = false
 

func _on_sliding_timeout() -> void:
	sliding_timer.paused = true
	hurt_box.process_mode = Node.PROCESS_MODE_PAUSABLE
	sliding = false
	

func _on_death_timer_timeout() -> void:
<<<<<<< Updated upstream
	print("you died")
	timer.paused = true
=======
	died()
	print("now") 
	timer.paused = true

func _on_slide_timeout() -> void:
	print("on slide timeout happened")
	can_slide_timer.paused = true
	stamina_bar.visible = false
	can_slide = true
>>>>>>> Stashed changes
