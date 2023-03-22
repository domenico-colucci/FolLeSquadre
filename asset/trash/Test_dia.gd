extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var caricati

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FileDialog_file_selected(path):
	load_JSON(path) # Replace with function body.

func load_JSON(path):
	var file=File.new()
	if not file.file_exists(path):
		return
	file.open(path,file.READ)
	var text=file.get_as_text()
	caricati=parse_json(text)
	print(caricati)

func _on_Button_button_up():
	$FileDialog.popup() # Replace with function body.
