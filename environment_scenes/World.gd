extends Node2D

# Sets up the world scene
func _ready():
	set_process(true)
	set_process_input(true)


# Processed every frame
func _process(delta):	
	update_HUD_bars()
	if $MobSpawner/Container.get_child_count() > 0:
		for mob in $MobSpawner/Container.get_children():
			if mob.position.x < $PlayerSpawner/Container.get_child(0).position.x:
				mob.get_node("Animations").flip_h = false
			else:
				mob.get_node("Animations").flip_h = true


# Updates the on-screen HUD stamina bar to reflect player's current stamina
func update_stamina_bar():
	$Canvas/HUD/Stamina.value = $PlayerSpawner/Container.get_child(0).stamina
	
	
# Updates the on-screen HUD health bar to reflect player's current health
func update_health_bar():
	$Canvas/HUD/Health.value = $PlayerSpawner/Container.get_child(0).health	

	
# Updates the on-screen HUD mana bar to reflect player's current mana
func update_mana_bar():
	$Canvas/HUD/Mana.value = $PlayerSpawner/Container.get_child(0).mana
	
	
	
func update_HUD_bars():
#	$Canvas/HUD/Stamina.max_value = $PlayerSpawner/Container.get_child(0).MAX_STAMINA
#	$Canvas/HUD/Stamina.rect_size = Vector2($PlayerSpawner/Container.get_child(0).MAX_STAMINA, 8)
	update_stamina_bar()	
	$Canvas/HUD/Health.max_value = $PlayerSpawner/Container.get_child(0).MAX_HEALTH
	$Canvas/HUD/Health.rect_size = Vector2($PlayerSpawner/Container.get_child(0).MAX_HEALTH, 8)
	update_health_bar()	
	$Canvas/HUD/Mana.max_value = $PlayerSpawner/Container.get_child(0).MAX_MANA
	$Canvas/HUD/Mana.rect_size = Vector2($PlayerSpawner/Container.get_child(0).MAX_MANA, 8)
	update_mana_bar()