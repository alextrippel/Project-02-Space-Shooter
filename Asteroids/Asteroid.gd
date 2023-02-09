extends KinematicBody2D

var velocity = Vector2(0, -200.0).rotated(randf()*2*PI)
var health = 10
var small_speed = 200
var score = 10
onready var Asteroid_small = load("res://Asteroids/S_Asteroid.tscn")
var small_asteroids = [Vector2(0,-30),Vector2(30,30),Vector2(-30,30)]
var dying = false

func _ready():
	velocity.rotated(randf()*2*PI)
	velocity *= randf()/2+0.5

func _physics_process(delta):
	position += velocity*delta
	position.x = wrapf(position.x, 0.0, Global.VP.x)
	position.y = wrapf(position.y, 0.0, Global.VP.y)	
	if not $CPUParticles2D.emitting and dying :
		queue_free()

func damage(d):
	health -= d
	if health <= 0 and not dying:
		collision_layer = 0
		var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Asteroid_Container != null:
			for s in small_asteroids:
				var asteroid_small = Asteroid_small.instance()
				var dir = randf()*2*PI
				var i = Vector2(0,randf()*small_speed).rotated(dir)
				Asteroid_Container.call_deferred("add_child", asteroid_small)
				asteroid_small.position = position + s.rotated(dir)
				asteroid_small.velocity = i
		Global.update_score(score)
		dying = true
		$CPUParticles2D.emitting = true


func _on_Area2D_body_entered(body):
	if body.name == "Player" or body.name == 'Player2':
		damage(100)
