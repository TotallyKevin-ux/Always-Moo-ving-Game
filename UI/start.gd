extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Test/test_level.tscn")


func _on_option_button_pressed():
	$OptionsMenu.visible = true
	$VBoxContainer.visible = false


func _on_exit_button_pressed() -> void:
	get_tree().quit()
