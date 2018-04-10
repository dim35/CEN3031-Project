extends "res://gui/StatBar.gd"

	
func _process(delta):
	if parent_entity != null:
		# Update the value of the bar each frame
		update(parent_entity.mana)
		# If the parent entity's max mana changed, we need to update the width
		if parent_entity.MAX_MANA != rect_size.x:
			set_dimensions(parent_entity.MAX_MANA)
			set_max_value(parent_entity.MAX_MANA)