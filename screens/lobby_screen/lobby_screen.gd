extends Control

var check = true # set to false to not check for players connected

export (PackedScene) var next_scene
onready var connected_players = get_node("connected_players")

var thumbnail_slots = []
var class_thumbnails = Dictionary()


func _ready():
	thumbnail_slots.append($Thumbnails/t1)
	thumbnail_slots.append($Thumbnails/t2)
	thumbnail_slots.append($Thumbnails/t3)
	thumbnail_slots.append($Thumbnails/t4)
	thumbnail_slots.append($Thumbnails/t5)
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
	
	if(check):
		$Button.disabled = true
	else:
		global_player.fake_register_player()
		update_list()



# Updates the player's class and displays the appropriate thumbnail above selection
func _class_selected(id):
	global_player.update_class($ClassDropdown.get_item_text(id))



# On each player list update, clear the graphic and reprint it for each player
func update_list():
	connected_players.clear()
	_clear_thumbnails()
	var players = global_player.player_info
	thumbnail_slots[2].texture = class_thumbnails[players[get_tree().get_network_unique_id()]["classtype"]]
	for p in players:
		var player_class = players[p]["classtype"]
		# If p is "you", skip
		if p == get_tree().get_network_unique_id():
			pass
		else:
			_get_leftmost_empty_slot().texture = class_thumbnails[player_class]
		connected_players.add_text(players[p]["username"] + " -> " + players[p]["classtype"] + "\n")
	$Button.disabled = (len(players) < 1 and check)




# Resets all thumbnails from the lobby
func _clear_thumbnails():
	for thumbnail in thumbnail_slots:
		thumbnail.texture = null



# Guaranteed to return the leftmost open slot
func _get_leftmost_empty_slot():
	var index
	for index in range(0, thumbnail_slots.size()):
		if thumbnail_slots[index].texture == null:
			return thumbnail_slots[index]



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