extends Control

const InvCellClass = preload("res://Scripts/GUI/Pause/Inventory/InvCell.gd")
@onready var inv_grid = $ItemInv
@onready var equips_grid = $EquipSlots
@onready var access_grid = $AccessorySlots
@onready var hotbar_grid = $HotBar

# Called when the node enters the scene tree for the first time.
func _ready():
	# intialize inventory
	var inv_cells = inv_grid.get_children()
	for i in range(inv_cells.size()):
		inv_cells[i].gui_input.connect(slot_gui_input.bind(inv_cells[i]))
		inv_cells[i].cell_index = i
		inv_cells[i].cell_type = InvCellClass.CellType.GENERAL
		
		# DEBUGGING
		inv_cells[i].init_item("Potion", 1)
		# DEBUGGING
		
	# intialize equip slots
	var equip_slots = equips_grid.get_children()
	for i in range(equip_slots.size()):
		equip_slots[i].gui_input.connect(slot_gui_input.bind(equip_slots[i]))
		equip_slots[i].cell_index = i
	equip_slots[0].cell_type = InvCellClass.CellType.HEAD
	equip_slots[1].cell_type = InvCellClass.CellType.SHIRT
	equip_slots[2].cell_type = InvCellClass.CellType.PANTS
	equip_slots[3].cell_type = InvCellClass.CellType.SHOES
	
	# DEBUGGING
	equip_slots[0].init_item("Winter Hat", 1) # head
	equip_slots[1].init_item("Worn Shirt", 1) # shirt
	equip_slots[2].init_item("Puffy Pants", 1) # pants
	equip_slots[3].init_item("Cozy Socks", 1) # shoes
	# DEBUGGING
	
	# ADD MORE HERE IF SIZE INCREASES SINCE THIS IS HARD CODED
	
	# initialize accessory slots
	var accessory_slots = access_grid.get_children()
	for i in range(accessory_slots.size()):
		accessory_slots[i].gui_input.connect(slot_gui_input.bind(accessory_slots[i]))
		accessory_slots[i].cell_index = i
		accessory_slots[i].cell_type = InvCellClass.CellType.ACCESSORY
		
		# DEBUGGING
		accessory_slots[i].init_item("Wooden Ring", 1)
		# DEBUGGING
		
	# initialize hotbar
	var hotbar_slots = hotbar_grid.get_children()
	for i in range(hotbar_slots.size()):
		hotbar_slots[i].gui_input.connect(slot_gui_input.bind(hotbar_slots[i]))
		hotbar_slots[i].cell_index = i
		hotbar_slots[i].cell_type = InvCellClass.CellType.GENERAL
		
		# DEBUGGING
		hotbar_slots[i].init_item("Potion", 1)
		# DEBUGGING
	
	
		
func slot_gui_input(event: InputEvent, cell: InvCellClass):
	if event.is_action_pressed("Interact"):
			if MouseUI.holding_item != null:
				if !cell.item:
					# left click empty cell
					left_click_empty_cell(cell)
				elif MouseUI.holding_item.item_name != cell.item.item_name:
					# left click diff item cell
					left_click_diff_item(cell)
				else:	
					# left click same item cell
					left_click_same_item(cell)
			elif cell.item:
				# left click with empty mouse
				left_click_not_holding(cell)
		
func valid_cell(cell: InvCellClass):
	var holding_item = MouseUI.holding_item
	if holding_item == null:
		return true
	var held_item_type = JSONData.item_data[holding_item.item_name]["ItemType"]
	
	if cell.cell_type == InvCellClass.CellType.SHIRT:
		return held_item_type == "SHIRT"
	elif cell.cell_type == InvCellClass.CellType.PANTS:
		return held_item_type == "PANTS"
	elif cell.cell_type == InvCellClass.CellType.SHOES:
		return held_item_type == "SHOES"
	elif cell.cell_type == InvCellClass.CellType.HEAD:
		return held_item_type == "HEAD"
	elif cell.cell_type == InvCellClass.CellType.ACCESSORY:
		return held_item_type == "ACCESSORY"
		
	# return true since we're adding to a general or hotbar inv cell
	return true
	

func left_click_empty_cell(cell: InvCellClass):
	print("LEFT CLICK EMPTY CELL")
	if valid_cell(cell):
		print("VALID CELL")
		cell.put_into_cell(MouseUI.holding_item)
		MouseUI.holding_item = null

func left_click_diff_item(cell: InvCellClass):
	print("LEFT CLICK DIFF ITEM CELL")
	if valid_cell(cell):
		print("VALID CELL")
		# swap mouse ui item and cell item
		var old_mouse_ui_item = MouseUI.holding_item
		MouseUI.holding_item = cell.item
		MouseUI.remove_child(old_mouse_ui_item)
		cell.pick_up_from_cell()
		MouseUI._update_item_pos()
		cell.add_to_cell_without_editing_mouse(old_mouse_ui_item)
		
		
	
func left_click_same_item(cell: InvCellClass):
	print("LEFT CLICK SAME ITEM CELL")
	if valid_cell(cell):
		print("VALID CELL")
		var max_stack = int(JSONData.item_data[cell.item.item_name]["StackSize"])
		var able_to_add = max_stack - cell.item.quantity
		if able_to_add >= MouseUI.holding_item.quantity:
			cell.item.add_quantity(MouseUI.holding_item.quantity)
			MouseUI.holding_item.queue_free()
			MouseUI.holding_item = null
		else:
			cell.item.add_quantity(able_to_add)
			MouseUI.holding_item.sub_quantity(able_to_add)

func left_click_not_holding(cell: InvCellClass):
	print("LEFT CLICK NOT HOLDING CELL")
	MouseUI.holding_item = cell.item
	cell.pick_up_from_cell()
	MouseUI._update_item_pos()
	if MouseUI.holding_item:
		MouseUI.holding_item.unset_hovered_over()
		
