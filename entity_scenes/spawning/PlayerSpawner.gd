extends Node

const player = preload("res://entity_scenes/Player/Player.tscn")
var num_players = 1

func _ready():
	set_process(true)
	_spawn()

func _process(delta):
	# check through state of each entity currently in play
	if $Container.get_child_count() > 0:
		for entity in $Container.get_children():
			_check_position(entity)


# level-start spawn for each player
func _spawn():
	for entity in range(num_players):
		
		var new_player = player.instance()
		for node in get_parent().get_children():
			if node.get_name() == "PlayerSpawnPoints":
				new_player.set_position(node.get_child(0).get_global_position())
				$Container.add_child(new_player)
				break
	


# special case after initial death has occured
func _respawn():
	var new_player = player.instance()
	for node in get_parent().get_children():
		if node.get_name() == "PlayerSpawnPoints":
			new_player.set_position(node.get_child(0).get_global_position())
			$Container.add_child(new_player)
			break


# despawn player if fallen off play area
func _check_position(entity):
	if entity.get_position().y > 650:
		entity.queue_free()
		_respawn()