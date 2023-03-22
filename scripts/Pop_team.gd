extends Node2D

export (NodePath) var roles_path ="MarginContainer/HBoxContainer/Campi/HBox_roles/ruolo"
onready var ruoli = get_node(roles_path)

var giocatori: Dictionary
var roles=["d","c","a","p"]
var roles_verbose=["Difensore", "Centrocampista", "Attaccante","Portiere"]
var specific_role
var specific_name
var specific_force

func _ready():
	add_roles_items()
	$MarginContainer/HBoxContainer/Campi/HBox_name/LineEdit.grab_focus()
	
func add_roles_items():
	for item in roles_verbose:
		ruoli.add_item(item)
	ruoli.selected=-1	

func _on_LineEdit_text_entered(new_text):
	specific_name=String(new_text)
	print(new_text)

func _on_ruolo_item_selected(index):
	specific_role=roles[index]
	print(specific_role)

func _on_enter_force_value_changed(value):
	specific_force=value
	print(specific_force)


func _on_Salva_button_up():
	var nome=$MarginContainer/HBoxContainer/Campi/HBox_name/LineEdit.text
	if nome == '':
		$AcceptDialog.popup()
		return
	if specific_force == null:
		specific_force=1
	giocatori[nome]=[specific_role,specific_force]
	ruoli.selected=-1	
	$MarginContainer/HBoxContainer/Campi/HBox_name/LineEdit.text=''
	$MarginContainer/HBoxContainer/Campi/_force/enter_force.value=0
	$MarginContainer/HBoxContainer/Campi/HBox_name/LineEdit.grab_focus()
	print(giocatori) 


func _on_Vedi_immessi_button_up():
	$ColorRect/Immessi.text=String(len(giocatori))+" giocatori inseriti"+': ' 
	for p in giocatori:
		$ColorRect/Immessi.text+=String(p) + ' '


func _on_Concludi_team_button_up():
#	GlobVars.giocatori=giocatori
	get_tree().change_scene("res://Menu_iniziale.tscn")
	


func _on_Salva_su_disco_button_up():
	if len(giocatori)==0:
		return
	GlobVars.giocatori=giocatori
	get_tree().change_scene("res://scenes/save_data.tscn")
	
