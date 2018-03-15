extends "res://entity_scenes/ControllableEntity.gd"



# Initialize the Player entity with its attributes
func _ready():	
	MAX_HEALTH = 200
	MAX_MANA = 80
	MAX_STAMINA = 150
	MAX_DEFENSE = 300
	MAX_SPEED = 180
	
	health = MAX_HEALTH
	stamina = MAX_STAMINA
	speed = MAX_SPEED
	defense = MAX_DEFENSE
	mana = MAX_MANA
	pass	