extends Area2D
# The player's speed
export (int) var SPEED
# The player's velocity
var velocity = Vector2()



func _ready():	
	
	pass



func _process(delta):
	velocity.x = 0
	velocity.y = 0	
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
		$Animations.play()
	else:
		$Animations.animation = "idle"
	
	if velocity.x != 0:
		$Animations.animation = "walking"
		$Animations.flip_h = velocity.x < 0		
	
	position += velocity * delta
