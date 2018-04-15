extends Container

export var Item_ID = -1

func _ready():
	pass

# update the item count
func set_inventory_item_count(id, val):
	if Item_ID == id:
		$Count.text = str(val)
	