extends Node

const player = preload("res://entity_scenes/Player.tscn")
var num_players = 1

func _ready():
	set_process(true)
	_spawn()

func _process(delta):
	# check through state of each entity currently in play
	if get_node("Container").get_child_count() > 0:
		for entity in get_node("Container").get_children():
			_check_position(entity)


# level-start spawn for each player
func _spawn():
	for entity in range(num_players):
		
		var new_player = player.instance()
		var pos = Vector2()
		
		pos.x = get_viewport().get_visible_rect().size.x/5
		pos.y = get_viewport().get_visible_rect().size.y * (2 / 3)
		new_player.set_position(pos)
		
		get_node("Container").add_child(new_player)


# special case after initial death has occured
func _respawn():
	var new_player = player.instance()
	var pos = Vector2()
		
	pos.x = get_viewport().get_visible_rect().size.x/5
	pos.y = get_viewport().get_visible_rect().size.y * (2 / 3)
	new_player.set_position(pos)
	
	get_node("Container").add_child(new_player)


# despawn player if fallen off play area
func _check_position(entity):
	if entity.get_position().y > 650:
		entity.queue_free()
		print("Player died")
		_respawn()