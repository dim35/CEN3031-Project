extends "res://entity_scenes/AnimatedEntity.gd"



func _ready():
	$Animations.flip_h = true
	$Animations.play("walking")
	speed = 100



func _physics_process(delta):
	velocity.x = -speed
	move(velocity)
	pass