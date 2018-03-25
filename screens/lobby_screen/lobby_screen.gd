extends Node2D

onready var connected_players = get_node("connected_players")

func _ready():
	global_player.start_client()
	global_player.connect("player_list_changed", self, "update_list")
	pass


func update_list():
	connected_players.clear()
	var players = global_player.player_info
	for p in players:
		connected_players.add_text(players[p]["username"] + " -> " + players[p]["classtype"] + "\n")
