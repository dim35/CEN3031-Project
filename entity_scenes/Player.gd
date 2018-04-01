extends "res://entity_scenes/AnimatedEntity.gd"

# Represents all enemies within the range of the player
var enemies_in_range = Dictionary()


# Initialize the Player entity with its attributes
# func _ready():	
# 	pass	

slave var slave_pos = Vector2()
slave var slave_velocity = Vector2()
slave var slave_is_attacking = false

var last_direction = 0

var STAMINA_RUN_DEPLETION = 0.3
var STAMINA_JUMP_DEPLETION = 8
var STAMINA_ATTACK_DEPLETION = 0.6
var STAMINA_IDLE_REGEN = 0.4
var current_xp

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
	who = "player"

var is_attacking = false

func move():
	rpc_id(1, "set_to_idle")
	var is_attacking = false
	velocity = Vector2(0,0)
	var moved_this_itr = false
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		if Input.is_action_pressed("ui_shift"):
			velocity.x = -2*speed
			stamina = max(stamina - STAMINA_RUN_DEPLETION, 0) 
		moved_this_itr = true
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		if Input.is_action_pressed("ui_shift"):
			velocity.x = 2*speed
			stamina = max(stamina - STAMINA_RUN_DEPLETION, 0)
		moved_this_itr = true
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or test_move(transform, Vector2(0,1)):
			velocity.y = -1.5*speed
			stamina = max(stamina - STAMINA_JUMP_DEPLETION, 0) 
		moved_this_itr = true
	if Input.is_action_pressed("attack"):
		is_attacking = true
		stamina = max(stamina - STAMINA_ATTACK_DEPLETION, 0)
		moved_this_itr = true
	
	if moved_this_itr:
		rpc_id(1, "move", velocity, is_attacking)
	
	
	flip_state(last_direction)
	update_state(state)


func set_camera_me():
	get_node("Camera").current = true;

remote func remote_move(p, v, s, ld):
	position = p
	state = s
	last_direction = ld

func _on_Area2D_body_entered(body):
# 	# If the body is an enemy, add it to the dictionary
 	if body.collision_layer == Base.MOB_COLLISION_LAYER:	
 		enemies_in_range[body] = true



func _on_Area2D_body_exited(body):
# 	# If the body that left is an enemy, it is no longer a potential target for attacking
 	if body.collision_layer == Base.MOB_COLLISION_LAYER:	
 		enemies_in_range.erase(body)

func check_health():
	pass