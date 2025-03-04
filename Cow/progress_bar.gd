extends ProgressBar

var stamina = 0

# Called when the node enters the scene tree for the first time.
func init_stamina(_stamina):
	stamina = _stamina
	value = stamina
	max_value = 240


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	stamina = stamina + 1 
	value = stamina
