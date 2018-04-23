extends "res://entity_scenes/AnimatedEntity.gd"

var last_direction = 0
var STAMINA_RUN_DEPLETION = 0.3
var STAMINA_JUMP_DEPLETION = 8
var STAMINA_ATTACK_DEPLETION = 0.6
var STAMINA_IDLE_REGEN = 0.4
var SPELL_MANA_DEPLETION = 1
var SPELL_MANA_IDLE_REGEN = 0.2
var current_xp
var classtype
var username

var clock

func _ready():
	clock = 0
	who = "player"
	set_max_attributes(200, 80, 150, 300, 150, 15)
	$name.text = username
	$name.rect_scale = Vector2(0.25, 0.25)
	set_process(true)


func _process(delta):
	# only when label is drawen does it update the size
	# multiple the size by the scale and divide by 2 to center
	var pos = -$name.get_size().x*0.25*0.5
	$name.rect_position = Vector2(pos, $Animations.position.y - 15)
	clock += 1
	if clock > 500:
		clock = 0


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
			velocity.y = -1.5*150
			stamina = max(stamina - STAMINA_JUMP_DEPLETION, 0) 
			moved_this_itr = true
	if Input.is_action_pressed("attack"):
		is_attacking = true
		stamina = max(stamina - STAMINA_ATTACK_DEPLETION, 0)
		if classtype == "mage":
			mana = max(mana - SPELL_MANA_DEPLETION, 0)
		moved_this_itr = true
	
	if moved_this_itr:
		rpc_id(1, "move", velocity, is_attacking)
	
	if state == "idle":
		stamina = min(stamina + STAMINA_IDLE_REGEN, MAX_STAMINA)
		mana = min(mana + SPELL_MANA_IDLE_REGEN, MAX_MANA)
	
	flip_state(last_direction)
	update_state(state)


func set_camera_me():
	get_node("Camera").current = true;


remote func remote_move(p, v, s, ld):
	position = p
	state = s
	velocity = v
	last_direction = ld

func use_item(id):
	$PotionParticles.restart()
	$PotionParticles.rotation = PI*int(last_direction)+PI
	if(id == 0):
		$PotionParticles.process_material.color = Color(1, 0, 0)
	if(id == 1):
		$PotionParticles.process_material.color = Color(0, 1, 0)
	rpc_id(1, "restore_stats", id)
	$Item.play()

remote func update_stats(hp, mp, sta, def, agil, dmg):
	health = hp
	mana = mp
	stamina = sta
	defense = def
	speed = agil
	damage = dmg

remote func playDeath():
	$Death.play()

remote func playWilhelm():
	$Wilhelm.play()

remote func reset_clock():
	clock = 0