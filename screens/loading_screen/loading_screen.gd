extends Node2D

export (PackedScene) var next_scene
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _init():
	global_player.connect("finished_loading", self, "finished_loading")

func finished_loading():
	get_tree().change_scene_to(next_scene)
	queue_free()
	
func _process(delta):
	$CanvasLayer/ParallaxBackground/Camera2D.position.x += 2
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
