extends "res://entity_scenes/AnimatedEntity.gd"

# Attributes belonging to controllable characters
var STAMINA_RUN_DEPLETION = 0.3
var STAMINA_JUMP_DEPLETION = 8
var STAMINA_ATTACK_DEPLETION = 0.6
var STAMINA_IDLE_REGEN = 0.4
var current_xp

slave var slave_position = Vector2()
slave var slave_velocity = Vector2()

func _physics_process(delta):
	var inner_velocity = Vector2()
	if is_network_master():
	# Entity is moving left
		if Input.is_action_pressed("move_left"):
			velocity.x = -speed
			if Input.is_action_pressed("ui_shift"):
				velocity.x = -1.2*speed
				stamina = max(stamina - STAMINA_RUN_DEPLETION, 0)		
		
		# Player is moving right
		if Input.is_action_pressed("move_right"):
			velocity.x = speed
			if Input.is_action_pressed("ui_shift"):
				velocity.x = 1.2*speed
				stamina = max(stamina - STAMINA_RUN_DEPLETION, 0)
		
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
		
		for p in global_player.player_info:
			if p != get_network_master():
				rset_id(p, "slave_velocity", velocity)
		#rset("slave_velocity", inner_velocity)
	else:
		velocity = slave_velocity
		if velocity.x != 0 and is_on_floor():
			update_state("walking")
		
		# Player is falling
		elif !is_on_floor():
			update_state("falling")
		
		# Player is idle
		else:
			update_state("idle")	
		#position = slave_position
		
	# Updates player's movement based on their velocity
	velocity = move(velocity)
	slave_velocity = move(slave_velocity)
	$Animations.flip_h = velocity.x < 0