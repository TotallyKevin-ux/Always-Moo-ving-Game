extends Camera2D

@export var acceleration1: float = 100
@export var acceleration2: float = 100
@export var point: Vector2
var og_point
var fps
var epsilon: float = .5
var phase = Phase.Start
var direction
var isPanning = false
var velocity: Vector2
@onready var original_path = point - position
@onready var origin = position

func _ready() -> void:
	og_point = point
	isPanning = true

func _physics_process(delta: float) -> void:
	fps = delta
	if isPanning:
		phase = get_phase()
		velocity = get_velocity()
		position += velocity

func get_velocity() -> Vector2:
	var path = point - position
	direction = path.normalized()
	var current_acceleration: float
	match phase:
		Phase.Start: current_acceleration = acceleration1
		Phase.End: current_acceleration = acceleration2
	return velocity + (direction * current_acceleration * fps)

enum Phase { Start, End,}

func get_phase():
	var path = point - position
	var margin = (origin + og_point) / 2 - position 
	if original_path.x * path.x > 0 or original_path.y * path.y > 0:
		return Phase.Start
	#if abs(position.x - origin.x) < epsilon or abs(position.y - origin.y) < epsilon:
	elif margin.x < epsilon or margin.y < epsilon:
		isPanning = false
		print("fc")
		return Phase.Start
	point = origin
	return Phase.End
