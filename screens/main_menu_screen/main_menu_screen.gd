extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_pressed("ui_select"):
		var my_scene = load("res://environment_scenes/World.tscn")
		get_tree().change_scene_to(my_scene)
