extends KinematicBody2D
# The player's speed
export (int) var SPEED
# The player's velocity
var velocity = Vector2()



func _ready():	
	pass



func _physics_process(delta):
	
	# Reset velocity to blank slate
	velocity.x = 0
	velocity.y = 0	
	
	# Player is moving to the right
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	# Player is moving to the left
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	# If player moved
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$Animations.play()
	else:
		$Animations.animation = "idle"
	
	# Determine walking animation direction
	if velocity.x != 0:
		$Animations.animation = "walking"
		$Animations.flip_h = velocity.x < 0		
	
	# Move the player
	position += velocity * delta
