extends Node

signal menuActive

func _process(delta):
	setSound()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		menu()

var menuBool = false

func menu():
	emit_signal("menuActive")
	if menuBool == false:
		$Menu/Panel.show()
		$Menu/Panel/Quit_Game.grab_focus()
		menuBool = true
	else:
		$Menu/Panel.hide()
		menuBool = false

func setSound():
	global_menu.sound_level = $Menu/Panel/Change_Sound/PopupMenu/HSlider.value
	if (global_menu.isMute == false):
		if(global_menu.sound_level == 0):
			$BackgroundMusic.volume_db = -80
		if(global_menu.sound_level == 1):
			$BackgroundMusic.volume_db = -40
		if(global_menu.sound_level == 2):
			$BackgroundMusic.volume_db = -35
		if(global_menu.sound_level == 3):
			$BackgroundMusic.volume_db = -25
		if(global_menu.sound_level == 4):
			$BackgroundMusic.volume_db = -19
		if(global_menu.sound_level == 5):
			$BackgroundMusic.volume_db = -12
		if(global_menu.sound_level == 6):
			$BackgroundMusic.volume_db = -6
		if(global_menu.sound_level == 7):
			$BackgroundMusic.volume_db = 0
		if(global_menu.sound_level == 8):
			$BackgroundMusic.volume_db = 5
		if(global_menu.sound_level == 9):
			$BackgroundMusic.volume_db = 10
		if(global_menu.sound_level == 10):
			$BackgroundMusic.volume_db = 12
	else:
		$BackgroundMusic.volume_db = -80
# Network Friendly quit game function here
func quit_game():
	print ("The game is quit")
	get_tree().quit()

func muted():
	print("mute signal emitted")
	global_menu.isMute = true

func notmuted():
	print("mute signal emitted")
	global_menu.isMute = false