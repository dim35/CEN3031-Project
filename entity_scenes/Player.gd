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


func _ready():	
	pass


func _physics_process(delta):
	
	# Reset velocity to blank slate
	velocity.y += 10	
	
	# Player is moving to the right
	if Input.is_action_pressed("ui_right"):
		velocity.x += 5
		
	# Player is moving to the left
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 5
		
	elif Input.is_key_pressed(88):
		$Animations.play("attacking")
	
	# Player is not moving horizontally
	else:
		velocity.x = 0
		$Animations.play("idle")

	# If player is moving horizontally
	if velocity.x != 0:
		velocity = velocity.normalized() * speed
		$Animations.flip_h = velocity.x < 0	
		$Animations.play("walking")
	
	# Move the player
	move_and_slide(velocity)
