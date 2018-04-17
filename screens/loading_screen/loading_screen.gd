extends Node2D

var next_scene = null

func _init():
	global_player.connect("finished_loading", self, "finished_loading")

func finished_loading():
	if (next_scene != null):
		print(next_scene.get_name())
		get_tree().change_scene_to(next_scene)
		queue_free()
	else:
		print("Dun messed up")
		assert(true)
	

func _process(delta):
	$CanvasLayer/ParallaxBackground/Camera2D.position.x += 2
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
