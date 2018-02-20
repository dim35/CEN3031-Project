extends Node2D


func _process(delta):
	
	if $Mob.position.x < $Player.position.x:
		$Mob/Animations.flip_h = false
	else:
		$Mob/Animations.flip_h = true
		
	if $Player/Animations.animation == "walking" || $Player/Animations.animation == "jumping":
		$Canvas/HUD/Stamina.value -= 0.2
	
	elif $Player/Animations.animation == "attacking":
		$Canvas/HUD/Stamina.value -= 0.5
	
	elif $Player/Animations.animation == "idle":
		$Canvas/HUD/Stamina.value += 0.3
	