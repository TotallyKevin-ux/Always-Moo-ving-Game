extends CharacterBody2D
var bullet_path = preload("res://Props/bullet.tscn")

@export var player:Node2D

var can_fire = false


func _physics_process(delta: float) -> void:
	look_at(player.global_position)
	if can_fire == true:
		fire()
	
func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = rotation
	bullet.pos = $Node2D.global_position
	bullet.rota = global_rotation
	get_parent().add_child(bullet)
	can_fire = false

func _on_timer_timeout() -> void:
	can_fire = true # Replace with function body.
