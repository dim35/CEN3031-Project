extends Control

export (PackedScene) var next_scene
var next_scene_instance = null

onready var username_field = get_node("TextEdit")
onready var password_field = get_node("TextEdit2")
func _ready():
	print ("loaded login!")

# This has been connected from Button
func _on_Button_pressed():
	print("Button Pressed!")
	print(username_field.get_line(0))
	print(password_field.get_line(0))
	
	# do authentication here
	
	# Splash Screen ...
	splash_screen()

func splash_screen():
	print("Loading splash screen...")
	
	# Create instance
	next_scene_instance = next_scene.instance()
	get_parent().add_child(next_scene.instance())
	next_scene_instance.is_loading = false
	queue_free()