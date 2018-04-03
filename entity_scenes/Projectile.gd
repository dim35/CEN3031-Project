extends "res://entity_scenes/AnimatedEntity.gd"

func _ready():
	who = "projectile"
	
remote func remote_move(p, d):
	position = p
	flip_state(d > 0)