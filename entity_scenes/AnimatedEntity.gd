extends KinematicBody2D

const UP_DIRECTION = Vector2(0, -1)
const GRAVITY = 12
var who = "none"
var velocity = Vector2()
# Var instead of const to allow player leveling and mob scaling
var MAX_HEALTH
var MAX_MANA
var MAX_STAMINA
var MAX_DEFENSE
var MAX_SPEED
var MAX_DAMAGE
# # Current values as opposed to maxima
var health
var mana
var stamina
var defense
var speed
var damage
var state = "idle"


# Once the entity is ready, set its attributes
func _ready():
	set_max_attributes(100, 100, 100, 100, 100, 1)


# Initializes the entity's max and current class attributes
func set_max_attributes(hp, mp, sta, def, agil, dmg):
	MAX_HEALTH = hp
	MAX_MANA = mp
	MAX_STAMINA = sta
	MAX_DEFENSE = def
	MAX_SPEED = agil
	MAX_DAMAGE = dmg
	health = MAX_HEALTH
	mana = MAX_MANA
	stamina = MAX_STAMINA
	defense = MAX_DEFENSE
	speed = MAX_SPEED
	damage = MAX_DAMAGE	


func _process(delta):
	$Animations.play()


func apply_gravity():
	velocity.y += GRAVITY

	
func update():
	move_and_slide(velocity, UP_DIRECTION)

	
# Updates the entity's animation state
func update_state(state_name):
	$Animations.animation = state_name
	pass

	
func flip_state(x):
	$Animations.flip_h = x

	
func take_damage(x):
	health -= x

	
remote func delete_me():
	queue_free()
	
remote func set_health(h):
	health = h


remote func set_mana(m):
	mana = m


remote func set_stamina(s):
	stamina = s
