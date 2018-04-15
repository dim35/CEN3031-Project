extends Node2D

var who = "item"
var id = -1

onready var world = get_node("/root/World")

func _ready():
	
	pass

func select_sprite(i):
	id = i
	if i == 0:
		get_node("Sprite").texture = load("res://assets/animation_sprites/potion/potion1.png")
	if i == 1:
		get_node("Sprite").texture = load("res://assets/animation_sprites/potion/potion2.png")

remote func remote_move(p):
	position = p
	
remote func picked_up():
	world.item_picked_up(id)

remote func delete_me():
	queue_free()