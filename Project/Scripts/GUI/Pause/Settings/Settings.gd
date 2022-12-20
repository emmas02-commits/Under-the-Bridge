extends Control

var GAMEPLAY_SETTINGS = null
var GRAPHICS_SETTINGS = null
var SOUND_SETTINGS = null

enum SettingsMenuState {
	GAMEPLAY,
	GRAPHICS,
	SOUND
}

var state = null

# Called when the node enters the scene tree for the first time.
func _ready():
	GAMEPLAY_SETTINGS = get_node("GameplaySettings") as Control
	GRAPHICS_SETTINGS = get_node("GraphicsSettings") as Control
	SOUND_SETTINGS = get_node("SoundSettings") as Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
