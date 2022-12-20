extends Control

var INVENTORY = null
var SETTINGS = null

enum PauseMenuState {
	INV,
	SET
}

var state = null

# Called when the node enters the scene tree for the first time.
func _ready():
	INVENTORY = get_node("Inventory") as Control
	SETTINGS = get_node("Settings") as Control
	
	# sanity check
	if INVENTORY == null || SETTINGS == null:
		print("WARNING: Pause Menu did not find necessary nodes to work correctly")
		
	INVENTORY.visible = true
	SETTINGS.visible = false
	state = PauseMenuState.INV

# Called every frame. 'delta' is the elapsed time since the previous frame.

		
func _on_inv_button_pressed():
	if visible == false || state == PauseMenuState.INV:
		return
	SETTINGS.visible = false
	INVENTORY.visible = true
	state = PauseMenuState.INV
	
func _on_settings_button_pressed():
	if visible == false || state == PauseMenuState.SET:
		return
	INVENTORY.visible = false
	SETTINGS.visible = true
	state = PauseMenuState.SET
