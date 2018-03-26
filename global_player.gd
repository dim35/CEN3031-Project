extends Node
var username = "Nameless"
var classtype = "Knight"

var server_ip = "ec2-54-175-123-188.compute-1.amazonaws.com" # this will be overridden by login
var server_port = 5555

var player_info = {}

signal player_list_changed()
signal post_configure()
signal player_disconnect(id)

func start_client():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(server_ip, server_port)
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
	emit_signal("player_disconnect", id)

remote func register_player(id, info):
	player_info[id] = info
	emit_signal("player_list_changed")
	
func done_preconfiguring():
	rpc_id(1, "done_preconfiguring", get_tree().get_network_unique_id())
	
remote func post_configure_game():
	emit_signal("post_configure")
	
func fake_register_player():
	var my_info = { username = username, classtype = classtype }
	player_info[get_tree().get_network_unique_id()] = my_info