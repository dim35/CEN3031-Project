extends "res://entity_scenes/AnimatedEntity.gd"


func _ready():
	speed = 100
	update_state("walking")	



func _physics_process(delta):
	if $Animations.flip_h:
		velocity.x = -speed
	else:
		velocity.x = speed
	move(velocity)
	pass



func _on_Area2D_body_entered(body):
	if body.collision_layer == 4:
		print("Collided with a player!")
		update_state("attacking")
		


func _on_Area2D_body_exited( body ):
	if body.collision_layer == 4:
		update_state("walking")
	elif body.collision_layer == 1:
		velocity.y = 1.3*speed
