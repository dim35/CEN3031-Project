extends "res://Base.gd"



onready var entities = get_node("/root/World/entities")
onready var players = get_node("/root/World/entities/players")
onready var mobs = get_node("/root/World/entities/mobs")
onready var items = get_node("/root/World/entities/items")
onready var projectiles = get_node("/root/World/entities/projectiles")


onready var mob = preload("res://entity_scenes/Mob.tscn")
onready var player = preload("res://entity_scenes/Player.tscn")
onready var class_knight = preload("res://entity_scenes/class_knight.tscn")
onready var class_mage = preload("res://entity_scenes/class_mage.tscn")
onready var class_rogue = preload("res://entity_scenes/class_rogue.tscn")
onready var projectile = preload("res://entity_scenes/Projectile.tscn")
onready var item = preload("res://entity_scenes/Item.tscn")


var local_player_instance = null # use with caution as it's direct access
onready var inventory = {} # local player's inventory

func _ready():
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	global_player.connect("player_disconnect", self, "player_disconnect")
	
	# tell server i'm ready to recieve player data
	rpc_id(1, "feed_me_player_info", get_tree().get_network_unique_id())
	
	# set items to default amount (0)
	for i in range(5):
		inventory[i] = 0

remote func spawn(who, id, it_id = 0, b = 0):
	print("spawn! " + who + " " + str(id))
	if who == "mob":
		var m = mob.instance()
		m.set_name(str(id))
		mobs.add_child(m)
	elif who == "player":
		var p = null
		if it_id == "knight":
			p = class_knight.instance()
		elif it_id == "mage":
			p = class_mage.instance()
		elif it_id == "rogue":
			p = class_rogue.instance()
		p.classtype = it_id
		p.username = b
		p.set_name(str(id))
		if str(get_tree().get_network_unique_id()) == id:
			p.set_camera_me()
		players.add_child(p)
		if str(get_tree().get_network_unique_id()) == id:
			local_player_instance = get_node("/root/World/entities/players/" + str(get_tree().get_network_unique_id()))
	elif who == "projectile":
		var proj = projectile.instance()
		proj.set_name(str(id))
		projectiles.add_child(proj)
	elif who == "item":
		var new_item = item.instance()
		new_item.set_name(str(id))
		new_item.select_sprite(it_id)
		items.add_child(new_item)
	

func player_disconnect(id):
	for e in players.get_children():
		if e.get_name() == str(id):
			e.free()
			break

# Processed every frame
func _physics_process(delta):
	if local_player_instance != null:
		local_player_instance.move()
	update_HUD_bars()

# Updates all player HUD bar maxima, dimensions, and current values
func update_HUD_bars():
	if local_player_instance == null:
		return
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

func item_picked_up(id):
	# add another instance of item
	inventory[id] = inventory[id] + 1
	
	print ("Inventory: " + str(inventory))
	
	# call some GUI update

func _server_disconnected():
	var my_scene = load("res://screens/login_screen/login_screen.tscn")
	get_tree().change_scene_to(my_scene)
	queue_free()