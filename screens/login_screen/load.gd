extends Control

export (PackedScene) var next_scene
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Loading Thread
onready var loading_thread = Thread.new()
var next_scene_instance = null

func _ready():
	print (get_node("/node"))
	print ("Started")
	# Load Data...
	loading_thread.start(self, "load_data")
	
	# Splash Screen ...
	splash_screen()

func splash_screen():
	print("Loading splash screen...")
	
	# Create instance
	next_scene_instance = next_scene.instance()
	
	# Add to scene
	add_child(next_scene_instance)
	
func load_data(input):
	# Load data...
	print ("Loading data...")
	for i in range(0, 990):
		for j in range(0, 7):
			pass
	print ("Done loading data...")
	next_scene_instance.is_loading = false
	
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
