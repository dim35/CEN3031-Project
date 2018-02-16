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
	# Reset horizontal velocity each frame
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
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = -1.5*speed
	
	if Input.is_key_pressed(88):
		$Animations.play("attacking")
		velocity = Vector2(0,0)
		
	elif velocity.x != 0:
		$Animations.flip_h = velocity.x < 0	
		$Animations.play("walking")
	
	else:
		$Animations.play("idle")
	
	# Update player movement
	velocity = move_and_slide(velocity, UP_DIRECTION)
