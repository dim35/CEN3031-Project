extends "res://gui/StatBar.gd"

	
func _process(delta):
	if parent_entity != null:
		# Update the value of the bar each frame
		update(parent_entity.mana)
		change_color()
		# If the parent entity's max mana changed, we need to update the width
		if parent_entity.MAX_MANA != rect_size.x:
			set_dimensions(parent_entity.MAX_MANA)
			set_max_value(parent_entity.MAX_MANA)
			
			
func change_color():
	var foreground = get("custom_styles/fg")
	var r = float(value/max_value) * float(50.0/255) + 0.3
	var g = float(value/max_value) * float(50.0/255) + 0.5
	var b = float(value/max_value) * float(50.0/255) + 0.9
	foreground.bg_color = Color(r, g, b)
	pass