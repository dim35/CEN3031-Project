extends Node

const item = preload("res://entity_scenes/Item.tscn")
var spawn_freq = rand_range(1, 8)
var item_count = 0

func _ready():
	set_process(true)
	_spawn()


func _process(delta):
	if $Container.get_child_count() > 0:
		for entity in $Container.get_children():
			_check_position(entity)


# item spawning loop with irregular timer
func _spawn():
	
	# TODO: make 'while' an infinite loop and find way to pause spawning
	while item_count != 5:
		randomize()
		
		var pickup = item.instance()
		var pos = Vector2()
		
		pos.x = rand_range(0, get_viewport().get_visible_rect().size.x)
		pos.y = rand_range(0, get_viewport().get_visible_rect().size.y * (3/4))
		pickup.set_position(pos)
		
		$Container.add_child(pickup)
		item_count = item_count + 1
		yield(get_tree().create_timer(spawn_freq), "timeout")


# despawn item if fallen off play area
func _check_position(entity):
	if entity.get_position().y > 650:
		#print("Mob died")
		entity.queue_free()
		item_count = item_count - 1