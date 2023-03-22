extends Node

class_name Team

var players = []

func add_player(player):
	players.append(player)

class Player:
	var name = ""
	var role = ""
	var force_index = 0.0

	func get_data(giocatori,chi):
		name = chi
		role = giocatori[chi][0]
		force_index = giocatori[chi][1]

func build_team(giocatori):
#	var giocatori = GlobVars.giocatori
#	var team = self.new()
	for player_data in giocatori:
		var player = Player.new()
		print(player_data)
		player.get_data(giocatori,player_data)
		self.add_player(player)
#	return team
