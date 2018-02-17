extends KinematicBody2D
var velocity = Vector2()
var speed = 300
var health = 10
var defense = 10
const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 10



func _physics_process(delta):
	velocity.y += GRAVITY
	velocity.x = 0
	pass
	
	

func update_state():
	pass
	


func move(motion):
	move_and_slide(motion, UP_DIRECTION)
	pass
