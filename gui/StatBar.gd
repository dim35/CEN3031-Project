extends ProgressBar

# The entity whose stats it is reflecting (e.g., a player or a mob)
var parent_entity = null


# Gives the stat bar a reference to the parent entity
func set_parent_entity(entity):
	parent_entity = entity


# Updates the current value of the stat bar
func update(val):
	value = val
	

# Sets the maximum value this stat bar can assume
func set_max_value(val):
	max_value = val
	
	
# Sets the width and height of this stat bar
func set_dimensions(width, height=8):
	rect_size = Vector2(width, height)
	
	
# When called, modulates the stat bar's foreground color
func flash():
	pass