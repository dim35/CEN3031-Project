extends KinematicBody2D
# The player's speed
export (int) var speed
# The player's strength
var strength
# The player's health
var health
# The player's stamina
var stamina
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
	
	# Reset horizontal velocity each frame so it doesn't accumulate
	velocity.x = 0	
	
	# Player is moving to the right
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		# Pressing SHIFT - run 40% faster
		if Input.is_key_pressed(16777237):
			velocity.x = 1.4*speed
		
	# Player is moving to the left
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		# Pressing SHIFT - run 40% faster
		if Input.is_key_pressed(16777237):
			velocity.x = -1.4*speed
	
	# Player is jumping
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = -1.5*speed
	
	# Player is attacking via the X key
	if Input.is_key_pressed(88):
		$Animations.play("attacking")
		velocity = Vector2(0,0)
	
	# Elif because we assume a player does not attack while moving
	elif velocity.x != 0:
		$Animations.flip_h = velocity.x < 0	
		$Animations.play("walking")
	
	# Default to idle animation if the player is not doing any of the above
	else:
		$Animations.play("idle")
	
	
	# Prevents the player from walking off the edge of the screen
	position.x = clamp(position.x, 10, get_viewport_rect().size.x - 10)
	
	
	# Updates player's movement based on their velocity
	velocity = move_and_slide(velocity, UP_DIRECTION)
