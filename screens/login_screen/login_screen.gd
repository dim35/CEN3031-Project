extends Control

export (PackedScene) var next_scene

onready var username_field = get_node("Username_field")
onready var password_field = get_node("Password_field")
onready var address_field = get_node("Address_field")

func _ready():
	print ("loaded login!")

# This has been connected from Button
func _on_Button_button_up():
	print("Button Pressed!")
	print(username_field.text)
	print(password_field.text)
	print(address_field.text)

	# do authentication here
	
	var my_scene = load("res://environment_scenes/World.tscn")
	get_tree().change_scene_to(my_scene)
	
	queue_free()

