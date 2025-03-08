extends CharacterBody2D

@export var player:Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var can_slide_timer :=  $Can_slide
@onready var sliding_timer :=  $Sliding
@onready var begin_dash := $Begin_dash
@onready var death := $"../../Death Timer"
@onready var dash_ex := $Sprite2D2

var active = false
var can_slide = true
var sliding = false
var begin_dash_ani = false
var tracking = true
var dash_direction = Vector2.ZERO
var target_position
var direction = Vector2.ZERO

const death_x = -5601
const death_y = -3090
const SPEED = 300.0

func _ready():
	dash_ex.visible = false

func _physics_process(_delta: float):
	if active:
		nav_agent.target_position = player.global_position
		direction = nav_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		if begin_dash_ani == true:
			velocity = Vector2.ZERO
		elif sliding == true:
			velocity = target_position * SPEED * 4
		else:
			velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

#func _on_death_timer_timeout() -> void:
	#position.x = death_x
	#position.y = death_y

func _on_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		active = true

func _on_can_dash_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if can_slide == true:
			can_slide = false
			dash_ex.visible = true
			target_position = (player.global_position - position).normalized()
			begin_dash_ani = true
			begin_dash.start()
			begin_dash.paused = false

func _on_begin_dash_timeout() -> void:
	begin_dash.paused = true
	begin_dash_ani = false
	dash_ex.visible = false
	sliding_func()

func sliding_func(): 
	sliding = true
	can_slide = false
	target_position = (player.global_position - position).normalized()
	can_slide_timer.start()
	can_slide_timer.paused = false
	sliding_timer.start()
	sliding_timer.paused = false

func _on_can_slide_timeout() -> void:
	can_slide_timer.paused = true
	can_slide = true

func _on_sliding_timeout() -> void:
	sliding_timer.paused = true
	sliding = false


func _on_death_timer_timeout() -> void:
	active = false
	position.x = death_x
	position.y = death_y
