extends "res://gui/StatBar.gd"
	
	
func _process(delta):
	if parent_entity != null:
		# Update the value of the bar each frame
		update(parent_entity.health)
		# If the parent entity's max health changed, we need to update the width
		if parent_entity.MAX_HEALTH != max_value:
			set_dimensions(parent_entity.MAX_HEALTH)
			set_max_value(parent_entity.MAX_HEALTH)