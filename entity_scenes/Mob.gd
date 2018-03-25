extends "res://entity_scenes/AnimatedEntity.gd"

var speed = 100
onready var entities = get_node("/root/World/entities")

func _ready():
	update_state("walking")	
	who = "mob"

func find_nearest_player():
	var minx = 5000
	var near = null
	for e in entities.get_children():
		if (e.who == "player"):
			var x = position.distance_to(e.position)
			if (x < minx):
				minx = x
				near = e
	return near

func move():
	if !is_on_floor():
		apply_gravity()
	var player = find_nearest_player()
	velocity.x = (2 * int(player.position > position) - 1)* speed
	
	flip_state(velocity.x < 0)
	update()
	pass


func _on_Area2D_body_entered(body):
	if body.collision_layer == PLAYER_COLLISION_LAYER:
		update_state("attacking")
	elif body.collision_layer == TILE_COLLISION_LAYER:
		velocity.y = -2 * speed
		


func _on_Area2D_body_exited( body ):
	if body.collision_layer == PLAYER_COLLISION_LAYER:
		update_state("walking")
