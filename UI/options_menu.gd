extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		go_back_to_main_menu()

func go_back_to_main_menu():
	get_parent().get_node("VBoxContainer").visible = true
	self.visible = false 
		
	
func _on_volume_value_changed(value: float):
	AudioServer.set_bus_volume_db(0,value)
	

func _on_mute_toggled(toggled_on):
	pass # Replace with function body.
	


func _on_back_button_pressed():
	visible = false
	get_parent().get_node("VBoxContainer").visible = true
