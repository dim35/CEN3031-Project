extends "res://entity_scenes/AnimatedEntity.gd"



# Var instead of const to allow player leveling
var MAX_HEALTH = 200
var MAX_MANA = 80
var MAX_STAMINA = 150
var MAX_DEFENSE = 300
var MAX_SPEED = 200


# Other attributes
var current_xp
var mana


# Stamina depletion and regen constants
const STAMINA_WALK_DEPLETION = 0.3
const STAMINA_JUMP_DEPLETION = 8
const STAMINA_ATTACK_DEPLETION = 0.6
const STAMINA_IDLE_REGEN = 0.4


# Initialize the Player entity with its attributes
func _ready():	
	health = MAX_HEALTH
	stamina = MAX_STAMINA
	speed = MAX_SPEED
	defense = MAX_DEFENSE
	mana = MAX_MANA
	pass



# Processed every frame
func _physics_process(delta):
	
	._physics_process(delta)

	if position.y >= 1200:
		update_player_position(70, 350)
	
	# TODO add back the "and stamina > 0" condition
	
	# Player is moving left
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		stamina = max(stamina - STAMINA_WALK_DEPLETION, 0)		
		$Animations.flip_h = velocity.x < 0		
	
	# Player is moving right
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		stamina = max(stamina - STAMINA_WALK_DEPLETION, 0)
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
			
	# Play whatever animation was set
	$Animations.play()
	
	# Updates player's movement based on their velocity
	velocity = move(velocity)



# Sets the player's position to (x, y)
func update_player_position(x, y):
		position.x = x
		position.y = y

	