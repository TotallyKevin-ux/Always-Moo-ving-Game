extends Control

var previous_menu: Control = null
@onready var blur_rect = $ColorRect 

var _is_paused:bool = false:
	set = set_paused
	
func _unhandled_input(event: InputEvent) -> void:
	if event .is_action_pressed("escape"):
		_is_paused = !_is_paused
	

func set_paused(value:bool) ->void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused
	blur_rect.visible = _is_paused

func _on_volume_value_changed(value: float):
	AudioServer.set_bus_volume_db(0,value)


func _on_how_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/how_to_play.tscn")


func _on_main_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/start.tscn")


func _on_story_btn_pressed() -> void:
	pass # Replace with function body.
	

func _on_close_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/start.tscn")
