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
	print(username_field.get_line(0))
	print(password_field.get_line(0))
	print(address_field.get_line(0))

	# do authentication here
	
	get_tree().change_scene_to(next_scene)
	queue_free()




