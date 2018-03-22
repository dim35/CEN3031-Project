extends ProgressBar


func update(val):
	value = val
	

func set_max_value(val):
	max_value = val
	
	
func set_dimensions(width, height=8):
	rect_size = Vector2(width, height)