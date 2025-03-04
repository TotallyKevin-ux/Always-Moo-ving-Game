class_name Cow
extends CharacterBody2D





const death_x = 0
const death_y = 0
var can_slide = true

@@ -16,12 +13,10 @@ var sliding = false
@onready var hurt_box := $"Hurt Box"
@onready var sliding_timer := $Sliding


const MAX_SPEED: int = 500 ## maximum speed in any direction
const ACCEL_VAL: int = 20 ## static acceleration value in any direction
const RESIST_VAL: int = 10 ## static acceleration value for "air resistance" that apply to any direction player is not moving in



var last_input_is_x: bool = false
var cur_vel: Vector2 = Vector2(0,0) ## current movement speed + direction

@@ -40,28 +35,20 @@ func _physics_process(delta: float) -> void:
		set_velocity(cur_vel)
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


@@ -123,10 +110,6 @@ func _on_sliding_timeout() -> void:
	

func _on_death_timer_timeout() -> void:




	died()
	print("now") 
	timer.paused = true

@@ -136,4 +119,3 @@ func _on_slide_timeout() -> void:
	can_slide_timer.paused = true
	stamina_bar.visible = false
	can_slide = true
