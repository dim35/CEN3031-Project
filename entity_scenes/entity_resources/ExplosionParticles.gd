extends Particles2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var timer = lifetime / speed_scale

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	timer -= delta
	if (timer < 0):
		queue_free()
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
