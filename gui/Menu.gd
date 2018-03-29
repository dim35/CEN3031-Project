extends CanvasLayer

signal closegame

func hideMenu():
	$Panel.hide()

func _on_Exit_Menu_pressed():
	hideMenu()


func _on_Quit_Game_pressed():
	emit_signal("closegame")
	pass # replace with game closing function
