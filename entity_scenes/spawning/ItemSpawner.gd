extends Node

const item = preload("res://entity_scenes/Item/Item.tscn")
var spawn_freq = rand_range(1, 8)
var item_count = 0

func _ready():
	set_process(true)
	_spawn()
	

func _process(delta):
	if $OnMapContainer.get_child_count() > 0:
		for entity in $OnMapContainer.get_children():
			_check_position(entity)
			
	if $MobDropContainer.get_child_count() > 0:
		for entity in $MobDropContainer.get_children():
			_check_position(entity)
	


# item spawning loop with irregular timer
func _spawn():
	# TODO: make 'while' an infinite loop and find way to pause spawning
	while item_count != 3:
		randomize()
		var pickup = item.instance()
		
		var spawn_index = 0

		for node in get_parent().get_children():
			if node.get_name() == "ItemSpawnPoints" && node.get_child_count() > 0:
				spawn_index = randi()%(node.get_child_count())
				if !node.get_child(spawn_index).is_occupied():
					pickup.set_position(node.get_child(spawn_index).get_global_position())
					$OnMapContainer.add_child(pickup)
					item_count = item_count + 1
					node.get_child(spawn_index).mark_occupied()
				break
	

# despawn item if fallen off play area
func _check_position(entity):
	if entity.get_position().y > 650:
		#print("Mob died")
		entity.queue_free()
		item_count = item_count - 1