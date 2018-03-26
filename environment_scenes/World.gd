extends "res://Base.gd"




# Processed every frame
func _process(delta):	
	update_HUD_bars()
	if $MobSpawner/Container.get_child_count() > 0:
		for mob in $MobSpawner/Container.get_children():
			
			mob.get_node("Health").update(mob.health)
			
			if mob.position.x < $PlayerSpawner/Container.get_child(0).position.x:
				mob.get_node("Animations").flip_h = false
			else:
				mob.get_node("Animations").flip_h = true



# Updates all player HUD bar maxima, dimensions, and current values
func update_HUD_bars():	
	var player = $PlayerSpawner/Container.get_child(0)
	var healthBar = $PlayerHUD/Stats/Health
	var manaBar = $PlayerHUD/Stats/Mana
	var staminaBar = $PlayerHUD/Stats/Stamina
	
	healthBar.set_max_value(player.MAX_HEALTH)
	healthBar.set_dimensions(player.MAX_HEALTH)
	healthBar.update(player.health)
	
	manaBar.set_max_value(player.MAX_MANA)
	manaBar.set_dimensions(player.MAX_MANA)
	manaBar.update(player.mana)
	
	staminaBar.set_max_value(player.MAX_STAMINA)
	staminaBar.set_dimensions(player.MAX_STAMINA)
	staminaBar.update(player.stamina)		



# Triggered upon body entering the area. Used mainly for player entry. Triggers level end.
func _on_GateArea_body_entered(body):
	if body.collision_layer == PLAYER_COLLISION_LAYER:
		$Gate.set_texture(load("res://assets/animation_sprites/environment/closed_gate.png"))
		$PlayerSpawner/Container.get_child(0).visible = false
		$LevelEndTimer.start()



# Changes to splash screen
func level_complete():
	var my_scene = load("res://screens/splash_screen/splash_screen.tscn")
	get_tree().change_scene_to(my_scene)



# When the timer reaches 0, trigger the end of the level
func _on_LevelEndTimer_timeout():
	level_complete()
