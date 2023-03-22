extends Node2D

export var MainAppScene : PackedScene	

func _ready():
	pass

func _onLoad_team_button_up():
	$choice_sound.play()
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().change_scene("res://scenes/Choose_load_format.tscn")

func _on_New_team_button_up():
	$choice_sound.play()
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().change_scene("res://scenes/Pop_team.tscn")

func _on_Fake_team_button_up():
	$choice_sound.play()
	yield(get_tree().create_timer(0.3), "timeout")
	var giocatori={"Aurelio":["d",3.5],"Chris":["c",2.5],"Darin":["a",1.25],"Donny":["c",0.5],"Dwayne":["d",2.25],"Evan":["a",0.25],"Foster":["c",1],"Grady":["c",0.25],"Hank":["p",3.5],"Jeremy":["p",2.5],"Jess":["d",1],"Jimmie":["a",1.75],"Joey":["d",1.75],"Kim":["a",3.5],"Mickey":["c",3.25],"Pasquale":["d",1.75],"Peter":["c",1.75],"Quinton":["c",0.5],"Romeo":["c",3.5],"Vern":["d",3]}
	GlobVars.giocatori=giocatori
	get_tree().change_scene("res://scenes/Pick_players.tscn")

func _on_Made_by_button_up():
	$choice_sound.play()
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().change_scene("res://scenes/credits.tscn") 

func _on_Help_button_up():
	$HelpWindow.popup_centered_minsize()

func _on_Exit_button_up():
	get_tree().quit()
