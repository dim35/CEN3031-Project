extends "res://entity_scenes/AnimatedEntity.gd"

onready var entities = get_node("/root/World/entities")

func _ready():
	update_state("walking")	
	who = "mob"

remote func remote_move(p, v, state):
	position = p
	velocity = v
	flip_state(velocity.x < 0)
	update_state(state)
	#if (abs(velocity.x) > 0):
	#	update_state("walking")

func take_damage(x):
	rpc_id(1, "take_damage", x)

remote func set_health(h):
	health = h

remote func delete():
	queue_free()

func check_health():
	if (health <= 0):
		queue_free()