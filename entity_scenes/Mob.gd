extends "res://entity_scenes/AnimatedEntity.gd"

# For testing collisions
var i = 0


func _ready():
	speed = 100
	$Animations.flip_h = true
	update_state("walking")



func _physics_process(delta):
	if $Animations.flip_h:
		velocity.x = -speed
		$Animations.position.x = -20
	else:
		velocity.x = speed
		$Animations.position.x = 0
	move(velocity)
	pass



func _on_Area2D_body_entered( body ):
	print(i)
	i+=1
	pass
