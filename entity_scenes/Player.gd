extends "res://entity_scenes/AnimatedEntity.gd"



# Stamina depletion and regen values
var STAMINA_RUN_DEPLETION = 0.3
var STAMINA_JUMP_DEPLETION = 8
var STAMINA_ATTACK_DEPLETION = 0.6
var STAMINA_IDLE_REGEN = 0.4

var current_xp


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



# Processed every frame
func _physics_process(delta):
	
	._physics_process(delta)
	
	# TODO add back the "and stamina > 0" condition
	
	# Player is moving left
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		if Input.is_action_pressed("ui_shift"):
			velocity.x = -1.2*speed
			stamina = max(stamina - STAMINA_RUN_DEPLETION, 0)		
		$Animations.flip_h = velocity.x < 0		
	
	# Player is moving right
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		if Input.is_action_pressed("ui_shift"):
			velocity.x = 1.2*speed
			stamina = max(stamina - STAMINA_RUN_DEPLETION, 0)
		$Animations.flip_h = velocity.x < 0
	
	# Player is jumping
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -1.5*speed
			stamina = max(stamina - STAMINA_JUMP_DEPLETION, 0)			
	
	# Player is attacking
	if Input.is_action_pressed("attack"):
		update_state("attacking")
		stamina = max(stamina - STAMINA_ATTACK_DEPLETION, 0)
	
	# Player is walking
	elif velocity.x != 0 and is_on_floor():
		update_state("walking")
	
	# Player is falling
	elif !is_on_floor():
		update_state("falling")
	
	# Player is idle
	else:
		velocity.x = 0
		update_state("idle")	
		stamina = min(stamina + STAMINA_IDLE_REGEN, MAX_STAMINA)
	
	# Updates player's movement based on their velocity
	velocity = move(velocity)
	