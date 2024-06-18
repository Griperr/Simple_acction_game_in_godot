extends Node2D

@onready var door = $colisions/Door

@onready var backgroud = $backgroud

@onready var bullets = $bullets
@onready var player = $player
@onready var meele = $meele
@onready var sqr_bullets = $sqr_bullets
@onready var squirrel = $squirrel
@onready var squirrel2 = $squirrel2
@onready var ele_meeles = $ele_meeles
@onready var elepahnt = $elephant


@onready var enemies = get_tree().get_nodes_in_group("Enemy")
@onready var enemycount = enemies.size()
@onready var cordtab=[Vector2i(100,8),Vector2i(100,9),Vector2i(100,10),Vector2i(100,11),
Vector2i(101,8),Vector2i(101,9),Vector2i(101,10),Vector2i(101,11)]

func _ready():
	
	Global.current_scene="world"
	
	player.connect("bullet_shot", _on_player_bullet_shot)
	player.connect("meele_stike", _on_player_meele)
	#squirrel.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel2.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	elepahnt.connect("ele_meele_strike",_on_ele_meele_strike)
	
	


func  _process(delta):
	enemies = get_tree().get_nodes_in_group("Enemy")
	enemycount = enemies.size()
	stagecleared()




func stagecleared():
	if enemycount == 0:
		backgroud.set_cell(0,cordtab[0],9,Vector2i(11,0))
		backgroud.set_cell(0,cordtab[1],9,Vector2i(11,1))
		backgroud.set_cell(0,cordtab[2],9,Vector2i(11,2))
		backgroud.set_cell(0,cordtab[3],9,Vector2i(11,3))
		backgroud.set_cell(0,cordtab[4],9,Vector2i(8,0))
		backgroud.set_cell(0,cordtab[5],9,Vector2i(8,1))
		backgroud.set_cell(0,cordtab[6],9,Vector2i(8,2))
		backgroud.set_cell(0,cordtab[7],9,Vector2i(8,3))
		
		door.set_deferred("disabled",true)
		

func  _on_player_bullet_shot(bullet):
	
	bullets.add_child(bullet)

func  _on_player_meele(meele_fx):
	meele.add_child(meele_fx)

func _on_shoot_sqr_bullet(sqr_bullet):
	sqr_bullets.add_child(sqr_bullet)

func _on_ele_meele_strike(ele_meele):
	ele_meeles.add_child(ele_meele)






func _on_area_2d_body_entered(body):
	if body.name == "player":
		Global.transition_scane = true
		change_scene()


func _on_area_2d_body_exited(body):
	if body.name == "player":
		Global.transition_scane = false

func  change_scene():
	if Global.transition_scane==true:
		if Global.current_scene == "world":
			get_tree().call_deferred("change_scene_to_file","res://scenes/level_1.tscn")
			#get_tree().change_scene_to_file("res://scenes/boss_level.tscn") 
