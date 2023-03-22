extends Node2D

var nameFile

func _ready():
	print(OS.get_name())
#	if OS.get_name()=="Android" or OS.get_name()=="X11":
#		$VBoxContainer/CenterContainer.visible=true
	if OS.get_name()=="Android":
		$VBoxContainer/CenterContainer5.visible=false
		$VBoxContainer/CenterContainer2.visible=false

func _on_ok_Button_button_up():
	nameFile="user://"+$VBoxContainer/CenterContainer/LineEdit.text
	print(nameFile)
	$FileDialog.popup()
#	if OS.get_name()=="Android":
#		saveData()
#	else:
#		$FileDialog.popup()

func saveData() -> void:
	var saveFile = File.new()
	saveFile.open(nameFile, File.WRITE)
	saveFile.store_var(GlobVars.giocatori)
	saveFile.close()


func _on_goback_button_up():
	get_tree().change_scene("res://scenes/Pick_players.tscn") 



func _on_FileDialog_file_selected(path):
	save_to(path) # Replace with function body.

func save_to(path):
	var saveFile = File.new()
	saveFile.open(path, File.WRITE)
	saveFile.store_line(to_json(GlobVars.giocatori))
	saveFile.close()


func _on_ok_internal_button_up():
	nameFile="user://"+$VBoxContainer/CenterContainer/LineEdit.text
	saveData()
