extends Node

var VP = Vector2.ZERO
var score = 0
var p1lives = 0
var p2lives = 0
var level = -1
var levels = [
	{
		"title":'Level 1',
		'subtitle': 'Destroy the asteroids',
		'asteroids': [Vector2(311,940), Vector2(3537,1811), Vector2(316,2737)],
		'enemies': [],
		'timer':60,
		'asteroids_spawned': false,
		'enemies_spawned': false,
		'Mov_enemies_spawned': false,
		'Mov_enemies': [Vector2(1,200)],
		'shieldpos':[Vector2(2000,1000)],
		'shield_spawned': false,
		'lifeup_spawned': false,
		'lifeup_pos': []
	},	
	{
		"title":'Level 2',
		'subtitle': 'Enemies Abound',
		'asteroids': [Vector2(2659,500), Vector2(941,150)],
		'enemies': [Vector2(2000,500), Vector2(2000,2500)],
		'timer':120,
		'asteroids_spawned': false,
		'enemies_spawned': false,
		'Mov_enemies_spawned': false,
		'Mov_enemies': [],
		'shieldpos':[Vector2(2000,2000)],
		'shield_spawned': false,
		'lifeup_spawned': false,
		'lifeup_pos': [Vector2(2000, 50)]
		
	},	
	{
		"title":'Level 3',
		'subtitle': 'Destroy Four Enemies',
		'asteroids': [Vector2(1140,1148), Vector2(512,1774)],
		'enemies': [Vector2(randf()*4000, randf()*3000), Vector2(randf()*4000, randf()*3000), Vector2(randf()*4000, randf()*3000)],
		'timer':100,
		'asteroids_spawned': false,
		'enemies_spawned': false,
		'Mov_enemies_spawned': false,
		'Mov_enemies': [Vector2(1,2800)],
		'shieldpos':[Vector2(1000,1500), Vector2(1000,1500)],
		'shield_spawned': false,
		'lifeup_spawned': false,
		'lifeup_pos': []
	},	
	{
		"title":'Level 4',
		'subtitle': 'Destroy the Asteroids',
		'asteroids': [Vector2(3611,100), Vector2(2380,100), Vector2(247,2037), Vector2(906,2572),Vector2(1722,1542), Vector2(1058,1692),Vector2(777,2687), Vector2(3557,1150)],
		'enemies': [Vector2(randf()*4000, randf()*3000)],
		'timer':100,
		'asteroids_spawned': false,
		'enemies_spawned': false,
		'Mov_enemies_spawned': false,
		'Mov_enemies': [Vector2(1,200)],
		'shieldpos':[Vector2(2000,1000), Vector2(2000,2000), Vector2(777,1952), Vector2(3557,512)],
		'shield_spawned': false,
		'lifeup_spawned': false,
		'lifeup_pos': [Vector2(2000, 50)]
	},	
	{
		"title":'Level 5',
		'subtitle': 'Final Level',
		'asteroids': [Vector2(247,1344), Vector2(906,1753),Vector2(1722,2425), Vector2(1058,1791),Vector2(777,1110), Vector2(3557,295),Vector2(2714,2669), Vector2(3691,415)],
		'enemies': [Vector2(2000,500), Vector2(2000,2500), Vector2(randf()*4000, randf()*3000)],
		'timer':100,
		'asteroids_spawned': false,
		'enemies_spawned': false,
		'Mov_enemies_spawned': false,
		'Mov_enemies': [Vector2(1,200), Vector2(1, 2600)],
		'shieldpos': [Vector2(2000,1000), Vector2(2000,2000)] ,
		'shield_spawned': false,
		'lifeup_spawned': false,
		'lifeup_pos': [Vector2(randf()*4000, randf()*3000)]
	},	
	
	
	
	
	
]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = Vector2(4000,3000)
	var _signal = get_tree().get_root().connect('size_changed',self,"_resize")
	reset()

func _physics_process(_delta):
	var A = get_node_or_null('/root/Game/Asteroid_Container')
	var B = get_node_or_null('/root/Game/Enemy_Container')	
	if A != null and B != null :
		var L = levels[level]
		if L['asteroids_spawned'] and L['enemies_spawned'] and A.get_child_count() == 0 and B.get_child_count() == 0 :
			next_level()

func reset():
	score = 0
	p1lives = 4
	p2lives = 4
	level = -1
	for l in levels:
		l['asteroids_spawned'] = false
		l['enemies_spawned'] = false
		l['shield_spawned'] = false
		
func _unhandled_input(_event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func _resize():
	VP = Vector2(4000,3000)

func update_score(s):
	score += s
	var Score = get_node_or_null('/root/Game/UI/HUD/Score')
	if Score != null:
		Score.text = 'Score: ' + str(score)

func update_lives(l, which_player):
	if which_player == 'Player':
		p1lives += l
	if which_player == 'Player2':
		p2lives += l
	if p1lives <= 0 and p2lives <= 0 :
		var _scene = get_tree().change_scene('res://UI/End_Game.tscn')
	var P1Lives = get_node_or_null('/root/Game/UI/HUD/P1Lives')
	var P2Lives = get_node_or_null('/root/Game/UI/HUD/P2Lives')
	if P1Lives != null and P2Lives != null:
		P1Lives.text = 'P1 Lives: '+str(p1lives)
		P2Lives.text = 'P2 Lives: '+str(p2lives)

func next_level():
	level += 1
	update_lives(1, 'Player')
	update_lives(1, 'Player2')
	if level >= levels.size() :
		var _scene = get_tree().change_scene('res://UI/End_Game.tscn')
	else :
		var Level_Label = get_node_or_null('/root/Game/UI/Level')
		if Level_Label != null:
			Level_Label.show_labels()
