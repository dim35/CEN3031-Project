extends "res://entity_scenes/AnimatedEntity.gd"



func _ready():
	speed = 100
	$Animations.flip_h = true
	update_state("walking")
	$Animations.play()



func _physics_process(delta):
	velocity.x = -speed
	move(velocity)
	pass