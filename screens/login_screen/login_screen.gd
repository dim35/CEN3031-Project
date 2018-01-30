extends Control

export (PackedScene) var next_scene

onready var username_field = get_node("TextEdit")
onready var password_field = get_node("TextEdit2")

func _ready():
	print ("loaded login!")

# This has been connected from Button
func _on_Button_button_up():
	print("Button Pressed!")
	print(username_field.get_line(0))
	print(password_field.get_line(0))

	# do authentication here
	
	get_tree().change_scene_to(next_scene)




