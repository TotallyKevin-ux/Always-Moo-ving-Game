extends CharacterBody2D

@onready var closed := $Sprite2D
@onready var shape := $CollisionShape2D
@onready var open := $Sprite2D2


func _ready():
	closed.visible = true
	open.visible = false
# Called when the node enters the scene tree for the first time.
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		closed.visible = false
		open.visible = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		open.visible = false
		closed.visible = true
