extends KinematicBody2D

onready var Enemy_Bullet = load('res://Enemy/Enemy_Bullet.tscn')
var nose = Vector2(0,-80)
var health = 30
var score = 100
var velocity = Vector2(5,0)

var wobble = 10

func _physics_process(_delta):
	position += velocity
	position.y = position.y + sin(position.x/80)*wobble
	position.x = wrapf(position.x, 0.0, Global.VP.x)
	position.y = wrapf(position.y, 0.0, Global.VP.y)
	
func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(score)
		queue_free()

func _on_Timer_timeout():
	var Player = get_node_or_null('/root/Game/Player_Container/Player')
	var Player2 = get_node_or_null('/root/Game/Player_Container/Player2')
	var Effects = get_node_or_null('/root/Game/Effects')
	if Player != null and Effects != null :
		var enemy_bullet = Enemy_Bullet.instance()
		enemy_bullet.originates = name
		var dir = global_position.angle_to_point(Player.global_position) - PI/2		
		enemy_bullet.global_position = global_position + nose.rotated(dir)
		enemy_bullet.rotation = dir
		Effects.add_child(enemy_bullet)
	if Player2 != null and Effects != null :
		var enemy_bullet2 = Enemy_Bullet.instance()
		enemy_bullet2.originates = name
		var dir2 = global_position.angle_to_point(Player2.global_position) - PI/2		
		enemy_bullet2.global_position = global_position + nose.rotated(dir2)
		enemy_bullet2.rotation = dir2
		Effects.add_child(enemy_bullet2)


func _on_Area2D_body_entered(body):
	if body.name == "Player" or body.name == 'Player2' or 'originates' in body:
		if body.originates != "MovingEnemy" :
			damage(100)
