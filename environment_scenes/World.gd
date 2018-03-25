extends "res://Base.gd"


#func _ready():
#	for p in global_player.player_info:
#		var player = preload("res://entity_scenes/Player.tscn").instance()
#		player.set_name(str(p))
#		get_node("/root/World/").add_child(player)

onready var entities = get_node("/root/World/entities")

func _ready():
	global_player.connect("player_disconnect", self, "player_disconnect")
	var player_scene = preload("res://entity_scenes/Player.tscn")
	for p_id in global_player.player_info:
		var player = player_scene.instance()

		player.set_name(str(p_id)) # Use unique ID as node name
		player.set_network_master(p_id) #set unique id as master

		#if (p_id == get_tree().get_network_unique_id()):
			# If node for this peer id, set name
		#	player.set_player_name(global_player.username)
		#else:
			# Otherwise set name from peer
		#	player.set_player_name(global_player.player_info[p_id]["username"])
		entities.add_child(player)
		
	var mob = preload("res://entity_scenes/Mob.tscn")
	entities.add_child(mob.instance())
	# $PlayerSpawner/Container.get_child(0).set_network_master(get_network_master())

func player_disconnect(id):
	for e in entities.get_children():
		if e.get_name() == str(id):
			e.free()
			break


# Processed every frame
func _process(delta):
	for n in entities.get_children():
		n.move()
		check_position(n)
	update_HUD_bars()
	# if $MobSpawner/Container.get_child_count() > 0:
	# 	for mob in $MobSpawner/Container.get_children():
			
	# 		mob.get_node("Health").update(mob.health)
			
	# 		if mob.position.x < $PlayerSpawner/Container.get_child(0).position.x:
	# 			mob.get_node("Animations").flip_h = false
	# 		else:
	# 			mob.get_node("Animations").flip_h = true
func check_position(entity):
	if entity.get_position().y > 650:
		if entity.who == "player":
			entity.position = Vector2(0,0)
		elif entity.who == "mob":
			entity.free()
	


# Updates all player HUD bar maxima, dimensions, and current values
func update_HUD_bars():	
	pass
# 	var player = $PlayerSpawner/Container.get_child(0)
# 	var healthBar = $PlayerHUD/Stats/Health
# 	var manaBar = $PlayerHUD/Stats/Mana
# 	var staminaBar = $PlayerHUD/Stats/Stamina
	
# 	healthBar.set_max_value(player.MAX_HEALTH)
# 	healthBar.set_dimensions(player.MAX_HEALTH)
# 	healthBar.update(player.health)
	
# 	manaBar.set_max_value(player.MAX_MANA)
# 	manaBar.set_dimensions(player.MAX_MANA)
# 	manaBar.update(player.mana)
	
# 	staminaBar.set_max_value(player.MAX_STAMINA)
# 	staminaBar.set_dimensions(player.MAX_STAMINA)
# 	staminaBar.update(player.stamina)		



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
