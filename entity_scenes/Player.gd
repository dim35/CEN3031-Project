extends KinematicBody2D
# The player's speed
export (int) var speed
# The player's strength
export (int) var strength
# The player's health
export (int) var health
# The player's stamina
export (int) var stamina
# The player's velocity
var velocity = Vector2()

# Defines the upward direction for the player as a unit vector
const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 10


func _ready():	
	pass


# Processed every frame
func _physics_process(delta):
	
	# Update vertical velocity each frame with gravity
	velocity.y += GRAVITY	
	
	# Player is moving to the right
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		
	# Player is moving to the left
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	
	elif Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = -1.5*speed
	
	elif Input.is_key_pressed(88):
		$Animations.play("attacking")
	
	# Player is not moving horizontally
	else:
		velocity.x = 0
		$Animations.play("idle")
	

	# If player is moving horizontally
	if velocity.x != 0:
		$Animations.flip_h = velocity.x < 0	
		$Animations.play("walking")
	
	# Move the player
	velocity = move_and_slide(velocity, UP_DIRECTION)
