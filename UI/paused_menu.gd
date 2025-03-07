extends Control


var _is_paused:bool = false:
	set = set_paused
	
func _unhandled_input(event: InputEvent) -> void:
	if event .is_action_pressed("escape"):
		_is_paused = !_is_paused
	

func set_paused(value:bool) ->void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused

func _on_resume_btn_pressed() -> void:
	_is_paused = false

func _on_how_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/how_to_play.tscn")


func _on_main_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/start.tscn")
