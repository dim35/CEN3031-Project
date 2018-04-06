extends Sprite




# Clears this player slot's username and image
func clear():
	$Username.text = ""
	$Image.texture = null
	
	

# Sets the username and image for this player slot
func set_slot(username, image):
	$Username.text = username
	$Image.texture = image
	