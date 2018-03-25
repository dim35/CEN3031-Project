extends Node2D

var check = false # set to false to not check for players connected

export (PackedScene) var next_scene
onready var connected_players = get_node("connected_players")

func _ready():
	global_player.start_client()
	global_player.connect("player_list_changed", self, "update_list")
	if(check):
		get_node("Button").disabled = true

func update_list():
	connected_players.clear()
	var players = global_player.player_info
	for p in players:
		connected_players.add_text(players[p]["username"] + " -> " + players[p]["classtype"] + "\n")
	if len(players) > 1 or !check:
		get_node("Button").disabled = false
	else:
		get_node("Button").disabled = true


func _on_Button_pressed():
	get_tree().change_scene_to(next_scene)
	
	queue_free()
	print("Start game...")
