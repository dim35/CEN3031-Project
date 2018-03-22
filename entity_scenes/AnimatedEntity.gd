extends KinematicBody2D


# Var instead of const to allow player leveling and mob scaling
var MAX_HEALTH = 100
var MAX_MANA = 100
var MAX_STAMINA = 100
var MAX_DEFENSE = 100
var MAX_SPEED = 100
var MAX_DAMAGE = 10


# Current values as opposed to maxima
var velocity
var health 
var mana 
var stamina 
var defense 
var speed
var damage


# Other constants that apply to all animated entities
const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 12



func _ready():
	velocity = Vector2()
	health = MAX_HEALTH
	mana = MAX_MANA
	stamina = MAX_STAMINA
	defense = MAX_DEFENSE
	speed = MAX_SPEED
	damage = MAX_DAMAGE




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
	
	
	
func take_damage(value):
	health -= value