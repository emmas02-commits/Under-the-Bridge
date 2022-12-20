extends Node

enum SCENE_STATE {IN_GAME, MAIN_MENU, PAUSE}

var scene

var PAUSE_CTRL = null
const PAUSE_MENU_PATH = "/root/World/Player/PauseMenu"
const MAIN_MENU_PATH = "res://GUI/MainMenu.tscn"
const IN_GAME_PATH = "res://World/World.tscn"

const END_BUTTON_PATH = PAUSE_MENU_PATH + "/Settings/ExitGameButton"

# Called when the node enters the scene tree for the first time.
func _ready():
	scene = SCENE_STATE.IN_GAME
	PAUSE_CTRL = get_node(PAUSE_MENU_PATH)
	if PAUSE_CTRL != null:
		PAUSE_CTRL.visible = false
	else:
		print("WARNING: SceneManager was unable to find PAUSE_CTRL")
	
	var end_button = get_node(END_BUTTON_PATH)
	if end_button:
		end_button.pressed.connect(self.exit_game)
	else:
		print("WARNING: SceneManager was unable to find END_BUTTON")
	#get_tree().change_scene_to_file(IN_GAME_PATH)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_inv_display_changes()
	
func process_inv_display_changes():
	if scene == SCENE_STATE.MAIN_MENU: # if in main menu this whole thing is irrelevant
		return
	if scene == SCENE_STATE.IN_GAME:
		if Input.is_action_just_pressed("toggle_pause"):
			print("PAUSE")
			scene = SCENE_STATE.PAUSE
			PAUSE_CTRL.visible = true
			
	elif scene == SCENE_STATE.PAUSE:
		if Input.is_action_just_pressed("toggle_pause"):
			print("UNPAUSE")
			scene = SCENE_STATE.IN_GAME
			PAUSE_CTRL._on_inv_button_pressed() # force switch it back to inv
			PAUSE_CTRL.visible = false
	else:
		print("WARNING: SceneManager in broken state")

func exit_game():
	get_tree().quit()
