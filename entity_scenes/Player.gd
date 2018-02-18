extends "res://entity_scenes/AnimatedEntity.gd"


# Initialize the Player entity with attributes
func _ready():	
	speed = 200
	health = 15
	defense = 15
	pass



# Processed every frame
func _physics_process(delta):

	._physics_process(delta)

	# Player is moving to the right
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		# Pressing SHIFT - run 40% faster
		if Input.is_key_pressed(16777237):
			velocity.x = 1.4*speed
		
	# Player is moving to the left
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		# Pressing SHIFT - run 40% faster
		if Input.is_key_pressed(16777237):
			velocity.x = -1.4*speed
	
	# Player is jumping
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = -1.5*speed
	
	# Player is attacking via the X key
	if Input.is_key_pressed(88):
		update_state("attacking")
		velocity = Vector2(0,0)
	
	# "Else if" because we assume a player does not attack while moving
	elif velocity.x != 0:
		update_state("walking")
		$Animations.flip_h = velocity.x < 0	
	
	# Default to idle animation if the player is not doing any of the above
	else:
		update_state("idle")
	
	
	# Play whatever animation was set	
	$Animations.play()

	
	# Updates player's movement based on their velocity
	velocity = move(velocity)
	
	# print("Player") # for debugging purposes only
