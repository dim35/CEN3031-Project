extends "res://entity_scenes/ControllableEntity.gd"

# Represents all enemies within the range of the player
var enemies_in_range = Dictionary()


# Initialize the Player entity with its attributes
func _ready():	
	MAX_HEALTH = 200
	MAX_MANA = 80
	MAX_STAMINA = 150
	MAX_DEFENSE = 300
	MAX_SPEED = 150
	MAX_DAMAGE = 1
	
	health = MAX_HEALTH
	stamina = MAX_STAMINA
	speed = MAX_SPEED
	defense = MAX_DEFENSE
	mana = MAX_MANA
	damage = MAX_DAMAGE
	pass	




func _process(delta):	
	if $Animations.animation == "attacking":
		for enemy in enemies_in_range:
			enemy.take_damage(damage)			
	pass




func _on_Area2D_body_entered(body):
	# If the body is an enemy, add it to the dictionary
	if body.collision_layer == 2:	
		enemies_in_range[body] = true
	pass



func _on_Area2D_body_exited(body):
	# If the body that left is an enemy, it is no longer a potential target for attacking
	if body.collision_layer == 2:	
		enemies_in_range.erase(body)
	pass # replace with function body
