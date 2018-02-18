extends Node2D


func _process(delta):
	if $Mob.position.x < $Player.position.x:
		$Mob/Animations.flip_h = false
	else:
		$Mob/Animations.flip_h = true