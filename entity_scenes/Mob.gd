extends "res://entity_scenes/AnimatedEntity.gd"

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
	pass


func _on_Area2D_body_entered( body ):
	print(i)
	i+=1
	pass # replace with function body


func _on_Area2D_area_shape_entered( area_id, area, area_shape, self_shape ):
	print(i)
	pass # replace with function body
