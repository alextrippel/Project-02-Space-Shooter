extends KinematicBody2D

var velocity = Vector2(0, -200.0).rotated(randf()*2*PI)
var health = 5
var score = 30

func _ready():
	velocity.rotated(randf()*2*PI)
	velocity *= randf()/2+0.5

func _physics_process(delta):
	position += velocity*delta
	position.x = wrapf(position.x, 0.0, Global.VP.x)
	position.y = wrapf(position.y, 0.0, Global.VP.y)	

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(score)
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player" or body.name == "Player2":
		damage(100)
