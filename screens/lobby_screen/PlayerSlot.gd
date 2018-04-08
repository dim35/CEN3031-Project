extends Sprite

var player_id = null

# Clears this player slot's username, image, and ID
func clear():
	set_slot("", null, null)
	
	

# Sets the username, image, and player ID for this player slot
func set_slot(username, image, id):
	$Username.text = username
	$Image.texture = image
	player_id = id
	$Status.texture = null