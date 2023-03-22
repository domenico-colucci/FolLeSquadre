extends Node2D

var sq=GlobVars.scelta.duplicate() #per creare copia distinta
var chiari=sq[0].duplicate()
var scuri=sq[1].duplicate()


func _ready():
	field_teams()
	write_details()

func field_teams():
	clear_containers()
	var list_chiari=chiari.keys()
	list_chiari.sort()	
	var list_scuri=scuri.keys()
	list_scuri.sort()
	for p in list_chiari:
		var button = Button.new()
		button.text = String(p)
		if chiari[p][0]=='d':
			$dif_chiari.add_child(button)	
		if chiari[p][0]=='a':
			$att_chiari.add_child(button)
		if chiari[p][0]=='c':
			$lista_chiari.add_child(button)	
		else:
			$port_chiari.add_child(button)
		button.connect("pressed", self, "_button_pressed",[button])
		button.hint_tooltip="Clicca per inserire il giocatore con gli scuri"
	for p in list_scuri:
		var button = Button.new()
		button.text = String(p)
		if scuri[p][0]=='d':
			$dif_scuri.add_child(button)	
		if scuri[p][0]=='a':
			$att_scuri.add_child(button)
		if scuri[p][0]=='c':		
			$lista_scuri.add_child(button)	
		else:
			$port_scuri.add_child(button)	
		button.connect("pressed", self, "_button_pressed",[button])
		button.hint_tooltip="Clicca per inserire il giocatore con i chiari"
func clear_containers():
	var cosa=[$lista_chiari,$att_chiari,$dif_chiari,$lista_scuri,$att_scuri,$dif_scuri, $port_chiari,$port_scuri]
	for x in cosa:
		for n in x.get_children():
			x.remove_child(n)
			n.queue_free()

	
func write_details():
	var forza_c=0
	for p in chiari:
		forza_c+=chiari[p][1]
	var roles_chiari=count_roles(chiari)
	$forza_chiari.text=	"Forza: %s" % forza_c	
	$forza_chiari.text+= "\n"+ "Numero: %s" % len(chiari)
	var forza_s=0
	for p in scuri:
		forza_s+=scuri[p][1]
	var roles_scuri=count_roles(scuri)
	$forza_scuri.text=	"Forza: %s" % forza_s	
	$forza_scuri.text+= "\n"+ "Numero: %s" % len(scuri)

	
func _button_pressed(button: Button):
	$movePlayer.play()
	var who=button.text
	change_side(who)
	field_teams()
	write_details()

func change_side(who): #moves player who to other side
	if who in chiari:
		scuri[who]=chiari[who]
		chiari.erase(who)
	else:
		chiari[who]=scuri[who]
		scuri.erase(who)			

func count_roles(team):#who della squadra in ingresso, restituisce booleano
	var dif = 0
	var cen = 0
	var att = 0
	var port= 0
	for x in team.values():
		if x[0] == 'd':
			dif+=1
		if x[0] == 'c':
			cen+=1
		if x[0] == 'a':
			att+=1
		if x[0] == 'p':
			port+=1	
	return [dif, cen, att, port]


func _on_reset_button_pressed():
	chiari=GlobVars.scelta[0].duplicate()
	scuri=GlobVars.scelta[1] .duplicate()
	field_teams()
	write_details()


func _on_back_button_up():
	get_tree().change_scene("res://Menu_iniziale.tscn")

func _on_back2choice_button_up():
	get_tree().change_scene("res://scenes/Propose_teams.tscn")

func _on_share_button_up():
	$FileDialog.popup()

func _on_FileDialog_file_selected(path):
	_hide_buttons()
	yield(get_tree().create_timer(0.5), "timeout")
#	_hide_buttons()
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.save_png(path)
	_show_buttons()

func _hide_buttons():
	$reset_button.visible=false
	$share.visible=false
	$back.visible=false
	$back2choice.visible=false
	
	
func _show_buttons():
	$reset_button.visible=true
	$share.visible=true
	$back.visible=true
	$back2choice.visible=true
