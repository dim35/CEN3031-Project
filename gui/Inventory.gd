extends Container

# The entity whose items it is reflecting (e.g., a player or a mob)
var parent_entity = null

func _ready():
	pass

# Gives the inventory a reference to the parent entity
func set_parent_entity(entity):
	parent_entity = entity
