extends CanvasLayer

signal getmenu
signal mute
signal nomute

func _ready():
	#_on_CheckButton_toggled(global_menu.isMute)
	$CheckButton.pressed = global_menu.playSound

func _on_Button_pressed():
	emit_signal ("getmenu")

func _on_CheckButton_toggled(button_pressed):
	if(button_pressed == false):
		emit_signal("mute")
		print("mute")
	else:
		emit_signal("nomute")
		print("nomute")
