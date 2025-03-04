extends ProgressBar

var stamina = 0

func _physics_process(delta: float) -> void:
	stamina = stamina + 1
	value = stamina


func init_stamina(_stamina):
	stamina = _stamina
	max_value = 300
	value = stamina
