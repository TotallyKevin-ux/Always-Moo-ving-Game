extends CharacterBody2D

@export var player:Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

var active = false

const SPEED = 150.0

func _physics_process(_delta: float):
	var next_path_pos := nav_agent.get_next_path_position()
	var direction := global_position.direction_to(next_path_pos)

	velocity = direction * SPEED

	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Player"):
		active = true

<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
func path():
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	path()

<<<<<<< Updated upstream

func _on_death_timer_timeout() -> void:
	pass # Replace with function body.
=======
func _on_death_timer_timeout() -> void:
	pass # Replace with function body.


func _on_detection_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
>>>>>>> Stashed changes
