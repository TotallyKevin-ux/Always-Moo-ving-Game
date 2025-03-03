extends Node

@export var max: Vector2 ## Point on the spawn area rectangle with the biggest x & y values
@export var min: Vector2 ## Point on the spawn area rectangle with the smallest x & y values
@export var n_ufos: int ## Number of UFOs
@export var ufo_preload := preload("res://Props/ufo.tscn")
@export var R: int = 10000

func _ready() -> void:
	create_2()

# implementation I
func create_1():
	for ufo in n_ufos:
		var pos := Vector2.ZERO
		pos.x = min.x + max.x / n_ufos * ufo
		pos.y = randf_range(min.y, max.y)
		spawn(ufo_preload, self, pos)


# implementation II
func create_2():
	# Earlier spawned ufos
	var ufo_positions: PackedVector2Array = []
	for ufo in n_ufos:
		var is_spawned = false
		while !is_spawned:
			var pos := Vector2.ZERO
			pos.x = randf_range(min.x, max.x)
			pos.y = randf_range(min.y, max.y)
			if overlaps(pos, ufo_positions, R):
				break;
			spawn(ufo_preload, self, pos)
			is_spawned = true



func spawn(object_preload: PackedScene, parent: Node, pos: Vector2):
	var object = object_preload.instantiate()
	parent.add_child(object)
	object.position = pos

func overlaps(object: Vector2, avoidable_list: PackedVector2Array, radius: float):
	for avoidable in avoidable_list:
		if inside: return true
	return false


func inside(object: Vector2, avoidable: Vector2, radius: float):
	var distance = sqrt(pow(object.y - avoidable.y, 2) + pow(object.x - avoidable.x, 2))
	if distance <= radius:
		return true
	else: return false
