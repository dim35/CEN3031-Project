extends Node

const mob = preload("res://entity_scenes/Mob.tscn")
var spawn_freq = rand_range(1, 8)
var enemy_count = 0

func _ready():
	set_process(true)
	_spawn()

func _process(delta):
	if get_node("Container").get_child_count() > 0:
		for entity in get_node("Container").get_children():
			_check_position(entity)


# mob spawning loop with irregular timer
func _spawn():
	while true:
		randomize()
		
		var enemy = mob.instance()
		var pos = Vector2()
		
		pos.x = rand_range(0, get_viewport().get_visible_rect().size.x)
		pos.y = rand_range(0, get_viewport().get_visible_rect().size.y)
		enemy.set_position(pos)
		
		get_node("Container").add_child(enemy)
		enemy_count = enemy_count + 1
		yield(get_tree().create_timer(spawn_freq), "timeout")


# despawn enemy if fallen off play area
func _check_position(entity):
	if entity.get_position().y > 650:
		print("Mob died")
		entity.queue_free()