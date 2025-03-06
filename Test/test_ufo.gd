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
		path()
		var next_path_pos := nav_agent.get_next_path_position()
		var direction := global_position.direction_to(next_path_pos)
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func path():
	nav_agent.target_position = player.global_position


func _on_death_timer_timeout() -> void:
	pass # Replace with function body.

func _on_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		active = true
