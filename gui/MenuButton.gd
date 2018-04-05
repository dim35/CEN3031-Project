extends CanvasLayer

signal getmenu



func _on_Button_pressed():
	emit_signal ("getmenu")

