extends Node
var username = "Default"
var classtype = "Knight"

var SERVER_IP = "192.168.1.123"
var SERVER_PORT = 5555

var player_info = {}

signal player_list_changed()

func start_client():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	pass

func _connected_ok():
	print ("Connected to server... ")
	var my_info = { username = username, classtype = classtype }
	rpc("register_player", get_tree().get_network_unique_id(), my_info)
	
func _player_disconnected(id):
	player_info.erase(id)
	emit_signal("player_list_changed")

remote func register_player(id, info):
	player_info[id] = info
	emit_signal("player_list_changed")