extends Node2D


var giocatori:Dictionary
var presenti:Dictionary
var selected_players = []
var players_box 
# Called when the node enters the scene tree for the first time.
func _ready():
	if len(GlobVars.giocatori)==0:
		load_csv()
	else:
		giocatori=GlobVars.giocatori	
	pop_list()


func load_csv():
	var file = File.new()
	file.open("res://data/giocatori.dat",file.READ)
	while !file.eof_reached():
		var csv=file.get_csv_line()
		if csv.size()>1: 
			giocatori[csv[0]]=[csv[1],float(csv[2])]
	file.close()
	

#func pop_list():
#	var players = giocatori.keys()
#	players.sort()
#	players_box = GridContainer.new()
#	players_box.columns=2
#	$MarginContainer/Container/VBox.add_child(players_box)
#	for item in giocatori:
#		var check_button = CheckButton.new()
#		check_button.text = item
#		players_box.add_child(check_button)
#		check_button.connect("toggled", self, "_on_item_toggled", [item])

func pop_list():
	players_box = GridContainer.new()
	players_box.columns=2
	$MarginContainer/Container/VBox.add_child(players_box)
	for item in giocatori:
		var check_button = CheckButton.new()
		check_button.text = item
		players_box.add_child(check_button)
		check_button.connect("toggled", self, "_on_item_toggled", [item])

	
func _on_item_toggled(item, value):
	if item:
		selected_players.append(value)
		$selected.visible=true
		print(value)
	else:
		selected_players.erase(value)
	print("Selected players:", selected_players)
	$selected.text="Selezionati: "+String(len(selected_players))

	
	
func _on_Bottone_vai_pressed():
	if len(selected_players)<2:
		$None_selected_Window.popup_centered()
	else:
		$vai.play()
		yield(get_tree().create_timer(0.5), "timeout")
		create_present_dic()
		GlobVars.presenti=presenti
		get_tree().change_scene("res://scenes/Propose_teams.tscn")
	
func stampa_presenti(pres):
	print('PRESENTI:')
	print(' '.join(pres.keys()))
	print('-----------------')	

func create_present_dic(): 
	for p in selected_players:
		presenti[p]=giocatori[p]


func _on_edit_team_button_button_up():
	get_tree().change_scene("res://scenes/Edit_team.tscn")


func _on_select_all_button_up():
	var gridCon=$MarginContainer/Container/VBox.get_children()
	for child in players_box.get_children():
		child.pressed=true
		print(child.text)


func _on_go_back_button_up():
	get_tree().change_scene("res://Menu_iniziale.tscn")
