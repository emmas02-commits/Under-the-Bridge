extends Control

var holding_item = null # Item Type

# Called when the node enters the scene tree for the first time.
func _ready():
	set_z_index(6)
	
func _input(event):
	_update_item_pos()

func _update_item_pos():
	if holding_item:
		holding_item.global_position = get_global_mouse_position() 
