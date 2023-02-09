extends Node2D

onready var Enemy = load('res://Enemy/Enemy.tscn')
onready var Moving = load('res://Enemy/MovingEnemy.tscn')

func _physics_process(_delta):
	if get_child_count() <= 3 and Global.level < Global.levels.size():
		var level = Global.levels[Global.level]
		if not level['enemies_spawned'] :
			for pos in level['enemies']:
				var enemy = Enemy.instance()
				enemy.position = pos
				add_child(enemy)
			level['enemies_spawned'] = true
		if not level['Mov_enemies_spawned'] :
			for pos in level['Mov_enemies']:
				var mov_enemy = Moving.instance()
				mov_enemy.position = pos
				add_child(mov_enemy)
			level['Mov_enemies_spawned'] = true

