extends "res://gui/StatBar.gd"
	
	
func _process(delta):
	if parent_entity != null:
		# Update the value of the bar each frame
		update(parent_entity.stamina)
		flash()
		# If the parent entity's max stamina changed, we need to update the width
		if parent_entity.MAX_STAMINA != rect_size.x:
			set_dimensions(parent_entity.MAX_STAMINA)
			set_max_value(parent_entity.MAX_STAMINA)


func flash():
	var foreground = get("custom_styles/fg")
	print(100/255)
	var r = float(value/max_value) * float(40.0/255) + 0.4
	var g = float(value/max_value) * float(40.0/255) + 0.6
	var b = float(value/max_value) * float(40.0/255) + 0.3
	foreground.bg_color = Color(r, g, b)
	pass