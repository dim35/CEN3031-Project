extends Node2D



# Sets up the world scene
func _ready():
	
	$Canvas/HUD/Stamina.max_value = $Player.MAX_STAMINA
	$Canvas/HUD/Stamina.rect_size = Vector2($Player.MAX_STAMINA, 8)
	update_stamina_bar()
	
	$Canvas/HUD/Health.max_value = $Player.MAX_HEALTH
	$Canvas/HUD/Health.rect_size = Vector2($Player.MAX_HEALTH, 8)
	update_health_bar()
	
	set_process(true)
	set_process_input(true)
	
	pass



# Processed every frame
func _process(delta):
	
	if $Mob.position.x < $Player.position.x:
		$Mob/Animations.flip_h = false
	else:
		$Mob/Animations.flip_h = true
	
	update_stamina_bar()
	
	pass
	
	

# Updates the on-screen HUD stamina bar to reflect player's current stamina
func update_stamina_bar():
	$Canvas/HUD/Stamina.value = $Player.stamina
	pass
	
	
	
# Updates the on-screen HUD health bar to reflect player's current health
func update_health_bar():
	$Canvas/HUD/Health.value = $Player.health