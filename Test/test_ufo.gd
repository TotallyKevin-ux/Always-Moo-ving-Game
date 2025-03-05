extends CharacterBody2D

@export var player:Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var can_slide_timer :=  $Can_slide
@onready var sliding_timer :=  $Sliding
@onready var begin_dash := $Begin_dash

var active = false
var can_slide = true
var sliding = false
var begin_dash_ani = false
var tracking = true
var dash_direction = Vector2.ZERO
var target_position

const SPEED = 300.0



func _physics_process(_delta: float):
	if active:
		var next_path_pos := nav_agent.get_next_path_position()
		var direction := global_position.direction_to(next_path_pos)
		if begin_dash_ani == true:
			velocity = direction.normalized() * SPEED * -0.2
		elif sliding == true:
			velocity = target_position * 1000
		else:
			velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func path():
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
		path()

func _on_death_timer_timeout() -> void:
	pass # Replace with function body.

func _on_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		active = true



func _on_can_dash_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		begin_dash_ani = true
		tracking = false
		begin_dash.start()
		begin_dash.paused = false

func _on_begin_dash_timeout() -> void:
	begin_dash_ani = false
	sliding_func()

func sliding_func(): 
	if can_slide == true:
		target_position = (player.global_position - position).normalized()
		can_slide = false
		sliding = true
		can_slide_timer.start()
		can_slide_timer.paused = false
		sliding_timer.start()
		sliding_timer.paused = false
		

func _on_can_slide_timeout() -> void:
	can_slide = true

func _on_sliding_timeout() -> void:
	sliding = false
	tracking = true
