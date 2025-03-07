extends Control

@onready var controls_page = $controls
@onready var instructions_page = $instructions

var previous_menu = null


func _ready():
	controls_page.visible = true
	instructions_page.visible = false
	
	$controls/nextBtn.pressed.connect(_on_next_btn_pressed)
	$instructions/backBtn.pressed.connect(_on_back_btn_pressed)
	
func _on_next_btn_pressed():
	controls_page.visible = false
	instructions_page.visible = true

func _on_back_btn_pressed():
	controls_page.visible = true
	instructions_page.visible = false

func open_from(menu):
	previous_menu = menu
	visible = true
	menu.visible = false
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		close_how_to_play()

func close_how_to_play():
	if previous_menu:
		previous_menu.visible = true
	visible = false
