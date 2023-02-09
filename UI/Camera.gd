extends Camera2D


func _ready():
	pass

func _physics_process(_delta):
	var Player1 = get_node_or_null('/root/Game/Player_Container/Player')
	var Player2 = get_node_or_null('/root/Game/Player_Container/Player2')
	if Player1 != null and Player2 != null :
		var p1 = Player1.global_position
		var p2 = Player2.global_position
		var center = (p1 + p2) / 2
		global_position = center
		var vp_size = get_viewport().size.length()
		var pdistance = p1 - p2
		var z = clamp(pdistance.length()*2.1/vp_size, 1, 3)
		zoom = Vector2(z,z)
	elif Player1 != null and Player2 == null:
		global_position = Player1.global_position
		zoom = Vector2(2.5,2.5)
	elif Player1 == null and Player2 != null:
		global_position = Player2.global_position
		zoom = Vector2(2.5,2.5)
