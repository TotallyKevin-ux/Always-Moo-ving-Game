extends StaticBody2D


func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.get_groups(): # TODO and got 3 keys
		print("You win.") # Load winning screen
