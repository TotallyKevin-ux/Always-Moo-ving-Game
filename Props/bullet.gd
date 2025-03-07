extends CharacterBody2D

var pos:Vector2
var rota:float
var dir:float
var speed = 1600


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = pos
	global_rotation = rota


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = Vector2(speed, 0).rotated(dir)
	move_and_slide()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("range"):
		queue_free() # Replace with function body.


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	queue_free()
