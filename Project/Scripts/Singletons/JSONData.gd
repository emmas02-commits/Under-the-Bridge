extends Node

var item_data: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	item_data = load_data("res://data/itemdata.json")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_data(file_path):
	var file_data = FileAccess.open(file_path, FileAccess.READ)
	var json = JSON.new()
	json.parse(file_data.get_as_text())
	file_data.flush()
	return json.get_data()	
