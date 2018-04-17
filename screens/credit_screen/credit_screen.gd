extends Control

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()