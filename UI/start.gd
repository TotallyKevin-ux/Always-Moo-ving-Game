extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	#get_tree().change_scene_to_file("res://Test/test_level.tscn")
	get_tree().change_scene_to_file("res://UI/cutscene_start.tscn")


func _on_option_button_pressed():
	get_tree().change_scene_to_file("res://UI/options_menu.tscn")
	
func _on_how_to_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/how_to_play.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_story_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/cutscene_menu.tscn")
