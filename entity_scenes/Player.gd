extends "res://entity_scenes/AnimatedEntity.gd"

# Represents all enemies within the range of the player
var enemies_in_range = Dictionary()

var speed = 200


# Initialize the Player entity with its attributes
# func _ready():	
# 	MAX_HEALTH = 200
# 	MAX_MANA = 80
# 	MAX_STAMINA = 150
# 	MAX_DEFENSE = 300
# 	MAX_SPEED = 150
# 	MAX_DAMAGE = 1
	
# 	health = MAX_HEALTH
# 	stamina = MAX_STAMINA
# 	speed = MAX_SPEED
# 	defense = MAX_DEFENSE
# 	mana = MAX_MANA
# 	damage = MAX_DAMAGE
# 	pass	

slave var slave_pos = Vector2()
slave var slave_motion = Vector2()
slave var is_attacking = false

var last_direction = 0

func _ready():
	if is_network_master():
		get_node("Camera").current = true;
	#position = Vector2(0,-100)
	pass
func move():
	is_attacking = false
	var is_attacking_ = false
	if is_network_master():
		velocity.x = 0
		if Input.is_action_pressed("move_left"):
			velocity += Vector2(-speed, 0)
		if Input.is_action_pressed("move_right"):
			velocity += Vector2(speed, 0)
		if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				velocity = Vector2(0, -1.5*speed)
		if Input.is_action_pressed("attack"):
			is_attacking_ = true;
		apply_gravity()
		for i in global_player.player_info:
			if i != get_network_master():
				rset_id(i, "slave_velocity", velocity)
				rset_id(i, "slave_pos", position)
				rset_id(i, "is_attacking", is_attacking)
	else:
		position = slave_pos
		velocity = slave_motion
		is_attacking_ = is_attacking
	
	var new_anim = "idle"
	if (velocity.x != 0):
		last_direction = velocity.x < 0
	if (is_attacking_):
		new_anim = "attacking"
	elif velocity.x != 0 and is_on_floor():
		new_anim = "walking"
	elif !is_on_floor():
		new_anim = "falling"
	
	flip_state(last_direction)
	
	update_state(new_anim)
		
	
	if (not is_network_master()):
		slave_pos = position
	update()

# func _process(delta):	
# 	if $Animations.animation == "attacking":
# 		for enemy in enemies_in_range:
# 			enemy.take_damage(damage)			
# 	pass




func _on_Area2D_body_entered(body):
# 	# If the body is an enemy, add it to the dictionary
# 	if body.collision_layer == MOB_COLLISION_LAYER:	
# 		enemies_in_range[body] = true
 	pass



func _on_Area2D_body_exited(body):
# 	# If the body that left is an enemy, it is no longer a potential target for attacking
# 	if body.collision_layer == MOB_COLLISION_LAYER:	
# 		enemies_in_range.erase(body)
 	pass # replace with function body
