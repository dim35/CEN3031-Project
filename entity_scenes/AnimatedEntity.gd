extends KinematicBody2D
signal under_attack


# Var instead of const to allow player leveling and mob scaling
var MAX_HEALTH = 100
var MAX_MANA = 100
var MAX_STAMINA = 100
var MAX_DEFENSE = 100
var MAX_SPEED = 100


# Current values as opposed to maxima
var velocity = Vector2()
var health = MAX_HEALTH
var mana = MAX_MANA
var stamina = MAX_STAMINA
var defense = MAX_DEFENSE
var speed = MAX_SPEED


const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 10


# Code processed every frame
func _physics_process(delta):
	velocity.y += GRAVITY
	velocity.x = 0
	# Plays whatever animation is currently set
	$Animations.play()
	pass
	
	
	
# Updates the entity's animation state
func update_state(state_name):
	$Animations.animation = state_name
	pass
	


# Moves the entity using a velocity vector and upward direction
func move(motion):
	return move_and_slide(motion, UP_DIRECTION)
	pass