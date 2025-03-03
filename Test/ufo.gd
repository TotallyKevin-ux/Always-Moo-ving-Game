extends CharacterBody2D

@export var player:Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var active = false

const SPEED = 150.0

func _physics_process(_delta: float):
	var next_path_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_pos)
	if active == true: 
		velocity = direction * SPEED
	else:
		velocity = Vector2(0,0)
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
