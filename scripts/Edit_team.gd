extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var giocatori={"Aurelio":["d",3.5],"Chris":["c",2.5],"Darin":["c",1.25],"Donny":["c",0.5],"Dwayne":["d",2.25],"Evan":["a",0.25],"Foster":["c",1],"Grady":["c",0.25],"Hank":["d",3.5],"Jeremy":["a",2.5],"Jess":["d",1],"Jimmie":["c",1.75],"Joey":["d",1.75],"Kim":["a",3.5],"Mickey":["c",3.25],"Pasquale":["d",1.75],"Peter":["c",1.75],"Quinton":["c",0.5],"Romeo":["c",3.5],"Vern":["d",3]}
onready var players_box = get_node("HBox/VBox/players_box")

var roles=["d","c","a","p"]
# Called when the node enters the scene tree for the first time.
func _ready():
	if len(GlobVars.giocatori)>0:
		giocatori=GlobVars.giocatori
	write_team_down()

func write_team_down():
	var lab1=Label.new()
	lab1.text="NOME"
	var lab1bis=Label.new()
	lab1bis.text="NOME"
	var lab2=Label.new()
	lab2.text="RUOLO"
	var lab2bis=Label.new()
	lab2bis.text="RUOLO"
	var lab3=Label.new()
	lab3.text="FORZA"
	var lab3bis=Label.new()
	lab3bis.text="FORZA"
	players_box.add_child(lab1)
	players_box.add_child(lab2)
	players_box.add_child(lab3)
	players_box.add_child(lab1bis)
	players_box.add_child(lab2bis)
	players_box.add_child(lab3bis)
	var list_pl=giocatori.keys()
	list_pl.sort()
	for p in list_pl:
		var name_field=Label.new()
		var role_field=OptionButton.new()
		for item in roles:
			role_field.add_item(item)
		role_field.selected=-1	
		var force_field=SpinBox.new()
		force_field.step=.05
		force_field.set_max(10)
		
		name_field.text=p
		role_field.text=giocatori[p][0]
		force_field.value=(giocatori[p][1])
		players_box.add_child(name_field)
		players_box.add_child(role_field)
		players_box.add_child(force_field)
	var name_field=LineEdit.new()
	var role_field=OptionButton.new()
	var force_field=SpinBox.new()
	force_field.step=.05
	force_field.set_max(10)
	players_box.add_child(name_field)
	players_box.add_child(role_field)
	for item in roles:
		role_field.add_item(item)
	role_field.selected=-1	
	players_box.add_child(force_field)	
		
		
func update_team():
	var data = {}
	for i in range(1,2+(players_box.get_child_count() / players_box.get_columns())):
		var row = []
		for j in range(players_box.get_columns()):
			row.append(players_box.get_child(i * players_box.get_columns() + j))
		print(row)
		if row[0]!=null:
			var key = row[0].get_text()
			var values = [row[1].get_text(), row[2].get_value()]
			if key !="":
				data[key] = values
		if row[3]!=null:
			var key = row[3].get_text()
			var values = [row[4].get_text(), row[5].get_value()]
			if key !="":
				data[key] = values
	giocatori=data
	for i in players_box.get_children():
		i.queue_free()
	write_team_down() # Replace with function body.

func _on_Usa_button_up():
	update_team()
	GlobVars.giocatori=giocatori
	get_tree().change_scene("res://scenes/Pick_players.tscn")

func _on_Annulla_button_up():
	get_tree().change_scene("res://scenes/Pick_players.tscn")

func _on_Aggiorna_button_up():
	update_team()

func _on_Salva_button_up():
	update_team()
	GlobVars.giocatori=giocatori
	get_tree().change_scene("res://scenes/save_data.tscn")
