extends Node2D

enum ItemTypes {
	MATERIAL = 0,
	PLACABLE,
	CONSUMABLE,
	SCYTHE,
	PICKAXE,
	AXE,
	HOE,
	HEAD,
	SHIRT,
	PANTS,
	SHOES,
	ACCESSORY
}

var item_name
var item_type # but how to go from string to enum
var quantity

const unhovered_scale = Vector2(.35, .35)
const hovered_scale = Vector2(.38, .38)

# Crafting State <-- Mandatory
# Consumable State <-- Maybe (store in child COSNUMABLE class oop)
# Tool State <-- Maybe (store in child TOOL class oop)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_scale(unhovered_scale)
	set_z_index(5)	
	
func set_item(name, quant):
	item_name = name
	quantity = quant
	$TextureRect.texture = load("res://assets/images/item_sprites/" + name + ".png")
	
	var stack_size = int(JSONData.item_data[item_name]["StackSize"])
	if quantity == 1:
		$Label.visible = false
	else:
		$Label.text = String.num_int64(quantity)

	
func add_quantity(amount):
	quantity += amount
	if not $Label.visible:
		$Label.visible = true
	$Label.text = String.num_int64(quantity)
	
func sub_quantity(amount):
	quantity -= amount
	if quantity == 1:
		$Label.visible = false
	else:
		$Label.text = String.num_int64(quantity)
		
func set_hovered_over():
	set_scale(hovered_scale)

func unset_hovered_over():
	set_scale(unhovered_scale)
	
