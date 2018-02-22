extends "res://entity_scenes/AnimatedEntity.gd"
const MAX_STAMINA = 150
const MAX_HEALTH = 200
var player_is_idle = true



# Initialize the Player entity with its attributes
func _ready():	
	speed = 200
	health = 200
	stamina = 150
	defense = 15
	pass



# Processed every frame
func _physics_process(delta):

	._physics_process(delta)
	
	# TODO add "and stamina > 0" condition
	
	# Player is moving left
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		stamina -= 0.3				
	
	# Player is moving right
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		stamina -= 0.3
	
	# Player is jumping
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -1.5*speed
			stamina -= 10			
	
	# Player is attacking
	if Input.is_action_pressed("attack"):
		update_state("attacking")
		stamina -= 0.5
	
	# Walking
	elif velocity.x != 0:
		update_state("walking")
		$Animations.flip_h = velocity.x < 0
	
	elif !is_on_floor():
		update_state("falling")
	
	# Player is idle
	else:
		velocity.x = 0
		update_state("idle")	
		stamina = min(stamina + 0.4, MAX_STAMINA)
	
	
	
	
	# Play whatever animation was set
	$Animations.play()
	
	# Updates player's movement based on their velocity
	velocity = move(velocity)







	