extends Area2D


func _ready():
	pass


func _on_Shieldbuff_body_entered(body):
	if body.name == "Player" or body.name == "Player2":
		body.shieldhp += 11
		queue_free()

func _on_Extralife_body_entered(body):
	if body.name == "Player" or body.name == 'Player2':
		Global.update_lives(1, body.name)
		queue_free()
