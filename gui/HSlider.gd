extends HSlider

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _process(delta):
	var string= self.value
	$Label.text = str(string)

