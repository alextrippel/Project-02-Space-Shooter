extends Node2D


func _ready():
	Global.update_lives(0, 'Player')
	Global.update_lives(0, 'Player2')
	Global.update_score(0)
	Global.next_level()
