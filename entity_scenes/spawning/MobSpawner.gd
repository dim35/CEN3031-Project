extends Node

const mob = preload("res://entity_scenes/Enemy/Mob.tscn")
var spawn_freq = rand_range(1, 8)
var enemy_count = 0

func _ready():
	set_process(true)
	_spawn()


func _process(delta):
	if $Container.get_child_count() > 0:
		for entity in $Container.get_children():
			_check_position(entity)


# mob spawning loop with irregular timer
func _spawn():
	
	# TODO: make 'while' an infinite loop and find way to pause spawning
	while enemy_count != 10:
		randomize()
		
		var enemy = mob.instance()
		
		# random index will be used to choose spawn point for mob
		var spawn_index = 0

		for node in get_parent().get_children():
			if node.get_name() == "MobSpawnPoints" && node.get_child_count() > 0:
				spawn_index = randi()%(node.get_child_count())
				
				enemy.set_position(node.get_child(spawn_index).get_global_position())
				$Container.add_child(enemy)
				enemy_count = enemy_count + 1
				break
		
		yield(get_tree().create_timer(spawn_freq), "timeout")


# despawn enemy if fallen off play area or health reached zero
func _check_position(entity):
	if entity.get_position().y > 650 or entity.health == 0:
		#print("Mob died")
		entity.queue_free()
		enemy_count = enemy_count - 1