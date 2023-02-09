extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 6.5
var max_speed = 750.0
var rot_speed = 5.5

var nose = Vector2(0,-70)
var health = 9


onready var Explosion = load('res://Effects/Explosion.tscn')
onready var Bullet = load("res://Player/Bullet.tscn")
var Effects = null

var PlanetA = null
var PlanetB = null
var PlanetC = null
var PlanetD = null
var planetlist = ['PlanetA', 'PlanetB','PlanetC','PlanetD']

var shieldhp = 11

var control = ['up', 'left', 'right', 'shoot']

func _ready():
	if name == 'Player2':
		control = ['up2', 'left2', 'right2', 'shoot2']

func _physics_process(_delta):
	if shieldhp > 0 :
		$Shield.show()
	else :
		$Shield.hide()
	var gravity = Vector2.ZERO
	PlanetA = get_node_or_null('/root/Game/PlanetA')
	PlanetB = get_node_or_null('/root/Game/PlanetB')
	PlanetC = get_node_or_null('/root/Game/PlanetC')
	PlanetD = get_node_or_null('/root/Game/PlanetD')
	var Planets = {PlanetA:25000,PlanetB:20000, PlanetC:30000, PlanetD:110000}
	for planet in Planets :
		if PlanetA != null :
			gravity += global_position.direction_to(planet.global_position)*Planets[planet]/pow(global_position.distance_to(planet.global_position),2)
			velocity += gravity
	velocity = velocity*(0.9925) + get_input()*speed
	velocity = velocity.normalized()*clamp(velocity.length(), 0 , max_speed)
	velocity = move_and_slide(velocity, Vector2.ZERO)
	position.x = wrapf(position.x, 0.0, Global.VP.x)
	position.y = wrapf(position.y, 0.0, Global.VP.y)
	
func get_input():
	$Exhaust.hide()
	var dir = Vector2.ZERO
	if Input.is_action_pressed(control[0]):
		$Exhaust.show()
		dir += Vector2(0,-1)
	if Input.is_action_pressed(control[1]):
		rotation_degrees -= rot_speed
	if Input.is_action_pressed(control[2]):
		rotation_degrees += rot_speed
	if Input.is_action_just_pressed(control[3]):
		shoot()
	return dir.rotated(rotation)

func damage(d):
	health -= d
	if health <= 0 :
		Effects = get_node_or_null('/root/Game/Effects')
		if Effects != null:
			var explosion = Explosion.instance()
			explosion.global_position = global_position
			Effects.add_child(explosion) 
	Global.update_lives(-1, name)
	queue_free()

func shoot():
	Effects = get_node_or_null('/root/Game/Effects')
	if Effects != null :
		var bullet = Bullet.instance()
		Effects.add_child(bullet)
		bullet.rotation = rotation
		bullet.originates = name
		bullet.global_position = global_position + nose.rotated(rotation)

func _on_Area2D_body_entered(body):
	if body != self and body.name != "Shield":
		if body.has_method('damage'):
			body.damage(10)
		damage(10)



func _on_Shield_area_entered(area):
	if 'damage' in area and shieldhp >= 0 and not area.name in planetlist and shieldhp > 0 :
		if 'originates' in area and area.originates != name :
			shieldhp -= area.damage
			area.queue_free()


func _on_Shield_body_entered(body):
	if body.name != "Player" and body.name != 'Player2' and shieldhp > 0:
		if body.has_method('damage'):
			body.damage(10)
		shieldhp -= 5
