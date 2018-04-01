extends KinematicBody2D

const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 12

var who = "none"
var velocity = Vector2()

# Var instead of const to allow player leveling and mob scaling
var MAX_HEALTH = 100
var MAX_MANA = 100
var MAX_STAMINA = 100
var MAX_DEFENSE = 100
var MAX_SPEED = 100
var MAX_DAMAGE = 10

# # Current values as opposed to maxima
var health = 0
var mana = 0
var stamina = 0
var defense = 0
var speed = 0
var damage = 0

var state = "idle"

func apply_gravity():
	velocity.y += GRAVITY
	
func update():
	move_and_slide(velocity, UP_DIRECTION)
	
func _process(delta):
	$Animations.play()
	
	
# Updates the entity's animation state
func update_state(state_name):
	$Animations.animation = state_name
	pass
	
func flip_state(x):
	$Animations.flip_h = x
	
func take_damage(x):
	health -= x