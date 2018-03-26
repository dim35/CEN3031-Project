extends "res://Base.gd"



onready var entities = get_node("/root/World/entities")
onready var players = get_node("/root/World/entities/players")
onready var mobs = get_node("/root/World/entities/mobs")
onready var items = get_node("/root/World/entities/items")

onready var mob = preload("res://entity_scenes/Mob.tscn")
var local_player_instance = null # use with caution as it's direct access

func _ready():
	global_player.connect("player_disconnect", self, "player_disconnect")
	
	# load all player and networked players
	var player_scene = preload("res://entity_scenes/Player.tscn")
	for p_id in global_player.player_info:
		var player = player_scene.instance()

		player.set_name(str(p_id)) # Use unique ID as node name
		player.set_network_master(p_id) #set unique id as master

		players.add_child(player)
		
	# obtain the player that is local
	local_player_instance = get_node("/root/World/entities/players/" + str(get_tree().get_network_unique_id()))
	

remote func spawn(who, id):
	print("spawn! " + who + " " + str(id))
	var m = mob.instance()
	m.set_name(str(id))
	mobs.add_child(m)

func player_disconnect(id):
	for e in entities.get_children():
		if e.get_name() == str(id):
			e.free()
			break


# Processed every frame
func _physics_process(delta):
	for p in players.get_children():
		# ssshhhh
		p.move()
		p.check_health()
		check_position(p)
		
		#TODO: server use player nodes
		rpc_id(1, "player_position", p.get_name(), p.position)
	update_HUD_bars()


func check_position(entity):
	if entity.get_position().y > 650:
		if entity.who == "player":
			entity.position = Vector2(0,0)
			entity.velocity.y = 0
		elif entity.who == "mob":
			entity.free()
	


# Updates all player HUD bar maxima, dimensions, and current values
func update_HUD_bars():	
	var healthBar = $PlayerHUD/Stats/Health
	var manaBar = $PlayerHUD/Stats/Mana
	var staminaBar = $PlayerHUD/Stats/Stamina
	
	healthBar.set_max_value(local_player_instance.MAX_HEALTH)
	healthBar.set_dimensions(local_player_instance.MAX_HEALTH)
	healthBar.update(local_player_instance.health)
	
	manaBar.set_max_value(local_player_instance.MAX_MANA)
	manaBar.set_dimensions(local_player_instance.MAX_MANA)
	manaBar.update(local_player_instance.mana)
	
	staminaBar.set_max_value(local_player_instance.MAX_STAMINA)
	staminaBar.set_dimensions(local_player_instance.MAX_STAMINA)
	staminaBar.update(local_player_instance.stamina)		



# Triggered upon body entering the area. Used mainly for player entry. Triggers level end.
func _on_GateArea_body_entered(body):
	if body.collision_layer == PLAYER_COLLISION_LAYER:
		$Gate.set_texture(load("res://assets/animation_sprites/environment/closed_gate.png"))
		# $PlayerSpawner/Container.get_child(0).visible = false
		$LevelEndTimer.start()



# Changes to splash screen
func level_complete():
	var my_scene = load("res://screens/splash_screen/splash_screen.tscn")
	get_tree().change_scene_to(my_scene)



# When the timer reaches 0, trigger the end of the level
func _on_LevelEndTimer_timeout():
	level_complete()
