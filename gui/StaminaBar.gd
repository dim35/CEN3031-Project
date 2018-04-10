extends "res://gui/StatBar.gd"
	
func _process(delta):
	if parent_entity != null:
		# Update the value of the bar each frame
		update(parent_entity.stamina)
		# If the parent entity's max stamina changed, we need to update the width
		if parent_entity.MAX_STAMINA != rect_size.x:
			set_dimensions(parent_entity.MAX_STAMINA)
			set_max_value(parent_entity.MAX_STAMINA)