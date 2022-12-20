extends Panel

const ItemClass = preload("res://Items/Item.tscn")

enum CellType {
	HOTBAR = 0, # anything can go in hotbar but it's 'usable'
	GENERAL,    # anything can go in general inventory
	
	HEAD, 	    # equip slots
	SHIRT,	    # -
	PANTS,	    # -
	SHOES,	    # -
	ACCESSORY   # equip slots
}

var item = null
var cell_type = null
var cell_index

var click_radius = 30

const item_pos_in_cell = Vector2(2, 2)

func _ready():
	pass

func pick_up_from_cell():
	remove_child(item)
	MouseUI.add_child(item)
	item = null
	
func put_into_cell(new_item):
	item = new_item
	item.position = item_pos_in_cell
	MouseUI.remove_child(item)
	add_child(item)

func add_to_cell_without_editing_mouse(new_item):
	item = new_item
	item.position = item_pos_in_cell
	add_child(item)
	
func init_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instantiate()
		add_child(item)
		item.position = item_pos_in_cell
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
		
func kill_item():
	if item != null:
		remove_child(item)
		item = null
		
func _on_mouse_entered():
	if item:
		item.set_hovered_over()
	
func _on_mouse_exited():
	if item:
		item.unset_hovered_over()
	
	
	
	
	
	
	
