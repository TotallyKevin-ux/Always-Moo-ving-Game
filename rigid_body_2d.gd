extends CharacterBody2D

@onready var animation := $AnimatedSprite2D
@onready var shape := $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _on_area_2d_area_entered(area: Area2D) -> void:
	$AnimatedSprite2D.frame = 2
