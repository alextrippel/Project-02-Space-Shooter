extends Node2D

onready var Shieldbuff = load('res://Weapons/Shieldbuff.tscn')
onready var Extralife = load('res://Weapons/Extralife.tscn')

func _physics_process(_delta):
	if get_child_count() == 0 and Global.level < Global.levels.size():
		var level = Global.levels[Global.level]
		if not level['shield_spawned']:
			for pos in level['shieldpos']:
				var shield = Shieldbuff.instance()
				shield.position = pos
				add_child(shield)
			level['shield_spawned'] = true
		if not level['lifeup_spawned']:
			for pos in level['lifeup_pos']:
				var life = Extralife.instance()
				life.position = pos
				add_child(life)
			level['lifeup_spawned'] = true


func _ready():
	pass
