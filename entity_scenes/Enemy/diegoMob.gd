extends "res://entity_scenes/AnimatedEntity.gd"

signal hit
signal dead
# For testing collisions
var i = 0


func _ready():
	speed = 100
	$Animations.flip_h = true
	update_state("walking")
	$Animations.play()


func _physics_process(delta):
	if $Animations.flip_h:
		velocity.x = -speed
	else:
		velocity.x = speed
	move(velocity)


func _on_Area2D_body_entered( body ):
	if body.get_parent() == get_tree().get_root().get_node("World/PlayerSpawner/Container"):
		print(i)
		i+=1

