extends Control

var check = true # set to false to not check for players connected

export (PackedScene) var next_scene
#onready var connected_players = get_node("connected_players")

var player_slots = []
var class_thumbnails = Dictionary()


# Prepares basic setup for lobby
func _ready():
	player_slots.append($Slots/Slot1)
	player_slots.append($Slots/Slot2)
	player_slots.append($Slots/Slot3)
	player_slots.append($Slots/Slot4)
	player_slots.append($Slots/Slot5)
	class_thumbnails["Knight"] = load("res://assets/animation_sprites/knight/knight-attacking-0.png")
	class_thumbnails["Mage"] = load("res://assets/animation_sprites/mage/mage_attacking_0.png")
	class_thumbnails["Rogue"] = load("res://assets/animation_sprites/rogue/rogue_attacking_0.png")
	$ClassDropdown.add_item("Knight")
	$ClassDropdown.add_item("Mage")
	$ClassDropdown.add_item("Rogue")
	$ClassDropdown.connect("item_selected", self, "_class_selected")
	global_player.start_client()
	global_player.connect("player_list_changed", self, "update_list")
	global_player.connect("post_configure", self, "post_configure")
	global_player.connect("existing_session", self, "existing_session")
	global_player.connect("new_player_ready", self, "new_player_ready")
	
	if(check):
		$Button.disabled = true
	else:
		global_player.fake_register_player()
		update_list()



# Updates the player's class
func _class_selected(id):
	global_player.update_class($ClassDropdown.get_item_text(id))



# the ready list has changed
func new_player_ready():
	for slot in player_slots:
		var status = slot.get_node("Status")
		if slot.get_node("Image").texture == null:
			status.text = ""
		elif slot.player_id in global_player.player_ready:
			status.text = "Ready"
		else:
			status.text = "Not Ready"
	#print(global_player.player_ready)



# On each player list update, clear the slots and reprint them for each player
func update_list():
	#connected_players.clear()
	_clear_player_slots()
	var players = global_player.player_info
	_place_me_in_middle_slot(players[get_tree().get_network_unique_id()])
	for p in players:
		var player_class = players[p]["classtype"]
		var player_username = players[p]["username"]
		if p == get_tree().get_network_unique_id():		# If p is "you", skip
			pass
		else:
			var leftmost_empty_slot = _get_leftmost_empty_slot()
			leftmost_empty_slot.set_slot(player_username, class_thumbnails[player_class], p)
		#connected_players.add_text(players[p]["username"] + " -> " + players[p]["classtype"] + "\n")
	$Button.disabled = (len(players) < 1 and check)



# Sets the current player in the middle slot
func _place_me_in_middle_slot(me):
	player_slots[2].set_slot(me["username"], class_thumbnails[me["classtype"]], me)



# Resets all player slots in the lobby
func _clear_player_slots():
	for slot in player_slots:
		slot.clear()



# Guaranteed to return the leftmost open slot
func _get_leftmost_empty_slot():
	var index
	for index in range(0, player_slots.size()):
		if player_slots[index].get_node("Image").texture == null:
			return player_slots[index]



func _on_Button_pressed():
	$Button.disabled = true
	if check:
		global_player.done_preconfiguring()
	else:
		post_configure()


	
func post_configure():
	get_tree().change_scene_to(next_scene)
	print("Start game...")
	queue_free()
	
	
	
func existing_session():
	get_tree().change_scene_to(load("res://screens/login_screen/login_screen.tscn"))
	queue_free()