extends "res://Scripts/Items/Item.gd"

var add_health
var add_energy

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _use():
	if quantity > 0:
		sub_quantity(1)
	else: # last consumable in stack
		find_parent("InvCell").kill_item()
