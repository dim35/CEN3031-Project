extends CanvasLayer

signal closegame
signal hidemenu

func _ready():
	$Panel/Change_Sound/PopupMenu/HSlider.value = global_menu.sound_level

func hideMenu():
	$Panel.hide()

func _on_Exit_Menu_pressed():
	hideMenu()
	emit_signal("hidemenu")

func _on_Quit_Game_pressed():
	emit_signal("closegame")

func _on_Change_Sound_pressed():
	$Panel/Change_Sound/PopupMenu.popup_centered()


