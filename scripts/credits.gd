extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$soundtrack.play() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_up():
	get_tree().change_scene("res://Menu_iniziale.tscn") # Replace with function body.


func _on_LinkButton_button_up():
	 OS.shell_open("mailto:domenico.colucci@protonmail.com")
