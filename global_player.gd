extends Node
var username = "Nameless"
var classtype = "Knight"

var server_ip = "ec2-54-175-123-188.compute-1.amazonaws.com" # this will be overridden by login
var server_port = 5555
var session_token = null

var player_info = {}
var player_ready = []

signal player_list_changed()
signal post_configure()
signal player_disconnect(id)
signal existing_session()
signal game_in_play()
signal new_player_ready()
signal finished_loading()

func start_client():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(server_ip, server_port)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)

func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
func _server_disconnected():
	get_tree().get_meta("network_peer").close_connection()
	player_info = {}
	
func _connected_ok():
	assert(session_token != null)
	print ("Connected to server... ")
	var my_info = { username = username, classtype = classtype }
	rpc("register_player", get_tree().get_network_unique_id(), my_info, session_token)
	
remote func existing_session():
	emit_signal("existing_session")
	get_tree().get_meta("network_peer").close_connection()
	

remote func game_in_play():
	emit_signal("game_in_play")
	get_tree().get_meta("network_peer").close_connection()
	
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
	
remote func change_class(id, c):
	player_info[id]["classtype"] = c
	emit_signal("player_list_changed")
	#print("changed " + player_info[id]["username"] + " to " + player_info[id]["classtype"])
	
func update_class(c):
	rpc("change_class", get_tree().get_network_unique_id(), c)
	change_class(get_tree().get_network_unique_id(), c) # update our list
	
remote func who_is_ready(players):
	player_ready = players
	emit_signal("new_player_ready")
	
remote func finished_loading():
	emit_signal("finished_loading")
	

remote func load_next_map(next_world):
	get_node("/root/World").set_name("OldWorldFreeing")
	get_node("/root/OldWorldFreeing").queue_free()
	var load_screen = load("res://screens/loading_screen/loading_screen.tscn").instance()
	load_screen.next_scene = load("res://environment_scenes/"+next_world+".tscn")
	get_tree().get_root().add_child(load_screen)
	
remote func we_done_bois():
	get_tree().get_meta("network_peer").close_connection()
	get_tree().change_scene_to(preload("res://screens/credit_screen/credit_screen.tscn"))
	get_node("/root/World").queue_free()