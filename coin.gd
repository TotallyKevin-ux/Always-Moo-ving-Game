extends Area2D



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		position.x = 600
		position.y = 600
	if area.is_in_group("dashing"):
		position.x = 600
		position.y = 600

func _on_death_timer_timeout() -> void:
	position.x = -345
	position.y = -382
