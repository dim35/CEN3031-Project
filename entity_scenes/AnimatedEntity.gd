extends KinematicBody2D

# ----------- All attributes of an animated entity -----------
var velocity = Vector2()
var speed = 300
var health = 10
var defense = 10
const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 10



func _physics_process(delta):
	# print("Super") # For debugging purposes only
	velocity.y += GRAVITY
	velocity.x = 0
	pass
	
	

func update_state(state_name):
	$Animations.animation = state_name
	pass
	


func move(motion):
	return move_and_slide(motion, UP_DIRECTION)
	pass
