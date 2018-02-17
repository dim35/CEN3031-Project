extends KinematicBody2D
var velocity
var health
var defense
const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 10


func _ready():
	pass



func _physics_process(delta):
	velocity.y += GRAVITY
	velocity.x = 0
	pass
	
	

func update_state():
	pass
	


func move():
	move_and_slide(velocity, UP_DIRECTION)
	pass
