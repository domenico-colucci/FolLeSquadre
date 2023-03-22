extends Control

func _ready():
	if OS.get_name()=="Android":
		$VBoxContainer/CSV_Container.visible=false
		$VBoxContainer/Info_csv.visible=false
		$VBoxContainer/JSON_Container2.visible=false
		$VBoxContainer/Info_json.visible=false
		$VBoxContainer/HBoxContainer/Instructions/Help.visible=false


func load_json(path):
	print("provo a caricare il file")
	var file=File.new()
	if not file.file_exists(path):
		print("Non trovo il file")
		return
	file.open(path,file.READ)
	var text=file.get_as_text()
	var giocatori=parse_json(text)
	print("Leggo i seguenti dati: ")
	print(giocatori)
	return(giocatori)

func _on_JSON_Button_button_up():
	$VBoxContainer/JSON_Container2/FileDialog.popup()
	
	

func load_csv(path):
	var giocatori={}
	var file = File.new()
	if not file.file_exists(path):
		print("Non trovo il file")
		return
	file.open(path,file.READ)
	while !file.eof_reached():
		var csv=file.get_csv_line()
		if csv.size()>1: 
			giocatori[csv[0]]=[csv[1],float(csv[2])]
	file.close()		
	return(giocatori)


func _on_CSV_Button_button_up():
	$VBoxContainer/CSV_Container/FileDialog_CSV.popup()

	
func notify_write_data(giocatori):
	if len(giocatori)>0:
		$VBoxContainer/HBoxContainer/Instructions/Notice.text='Caricati con successo i dati di '+String(len(giocatori))+ ' giocatori'
		$VBoxContainer/HBoxContainer/goplay_Button.disabled=false
		GlobVars.giocatori=giocatori
	if len(giocatori)==0:
		$VBoxContainer/HBoxContainer/Instructions/Notice.text='Non ho caricato nessun giocatore: problema col file?'


func _on_goplay_Button_button_up():
	get_tree().change_scene("res://scenes/Pick_players.tscn") 

func saveData(filename) -> void:
	var saveFile = File.new()
	saveFile.open(filename, File.WRITE)
	saveFile.store_line(to_json(GlobVars.giocatori))
	saveFile.close()


func _on_goback_Button_button_up():
	get_tree().change_scene("res://Menu_iniziale.tscn") 


func _on_FileDialog_file_selected(path):
	var giocatori={}
	giocatori=load_json(path)
	notify_write_data(giocatori) 


func _on_FileDialog_CSV_file_selected(path):
	var giocatori={}
	giocatori=load_csv(path)
	notify_write_data(giocatori)


func _on_previous_Button_button_up():
	print("Premuto carica file prec...")
	var nameFile="user://"+$VBoxContainer/PreviouslySaved/LineEdit.text
	print("path: "+nameFile)
#	var giocatori={}
	var file=File.new()
	if file.file_exists(nameFile):
		file.open(nameFile, File.READ)
		var giocatori=file.get_var()
		file.close()
		notify_write_data(giocatori)
	else:
		file.close()
		pass		

