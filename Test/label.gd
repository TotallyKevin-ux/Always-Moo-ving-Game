extends Label

var time_elapsed: float = 0.0

func _process(delta: float) -> void:
	time_elapsed += delta
	text = str(round_to(time_elapsed, 2))

func round_to(num: float,places: int):
	return (round(num*pow(10,places))/pow(10,places))
