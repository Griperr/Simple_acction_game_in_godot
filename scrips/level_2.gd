extends Node2D

@onready var attacks = $attacks

@onready var backgroud = $background
@onready var door = $colisions/door



@onready var player = $player
@onready var squirrel = $squirrel
@onready var squirrel_2 = $squirrel2
@onready var squirrel_3 = $squirrel3
@onready var squirrel_4 = $squirrel4
@onready var squirrel_5 = $squirrel5
@onready var squirrel_6 = $squirrel6
@onready var squirrel_7 = $squirrel7
@onready var squirrel_8 = $squirrel8
@onready var squirrel_9 = $squirrel9
@onready var squirrel_10 = $squirrel10
@onready var squirrel_11 = $squirrel11

@onready var elephant = $elephant
@onready var elephant_2 = $elephant2
@onready var elephant_3 = $elephant3
@onready var elephant_4 = $elephant4
@onready var elephant_5 = $elephant5



@onready var enemies = get_tree().get_nodes_in_group("Enemy")
@onready var enemycount = enemies.size()
@onready var cordtab=[Vector2i(203,26),Vector2i(204,26),Vector2i(205,26),Vector2i(206,26),
Vector2i(203,27),Vector2i(204,27),Vector2i(205,27),Vector2i(206,27),
Vector2i(203,28),Vector2i(204,28),Vector2i(205,28),Vector2i(206,28),
Vector2i(203,29),Vector2i(204,29),Vector2i(205,29),Vector2i(206,29)]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	Global.current_scene="level_2"
	
	player.connect("bullet_shot", _on_player_bullet_shot)
	player.connect("meele_stike", _on_player_meele)
	squirrel.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_2.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_3.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_4.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_5.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_6.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_7.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_8.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_9.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_10.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_11.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	elephant.connect("ele_meele_strike",_on_ele_meele_strike)
	elephant_2.connect("ele_meele_strike",_on_ele_meele_strike)
	elephant_3.connect("ele_meele_strike",_on_ele_meele_strike)
	elephant_4.connect("ele_meele_strike",_on_ele_meele_strike)
	elephant_5.connect("ele_meele_strike",_on_ele_meele_strike)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemies = get_tree().get_nodes_in_group("Enemy")
	enemycount = enemies.size()
	stagecleared()

func  _on_player_bullet_shot(bullet):
	
	attacks.add_child(bullet)

func  _on_player_meele(meele_fx):
	attacks.add_child(meele_fx)
	
func _on_shoot_sqr_bullet(sqr_bullet):
	attacks.add_child(sqr_bullet)

func _on_ele_meele_strike(ele_meele):
	attacks.add_child(ele_meele)






	



func  change_scene():
	if Global.transition_scane==true:
		if Global.current_scene == "level_2":
			get_tree().call_deferred("change_scene_to_file","res://scenes/boss_level.tscn")

func stagecleared():
	if enemycount == 0:
		backgroud.set_cell(0,cordtab[0],9,Vector2i(16,0))
		backgroud.set_cell(0,cordtab[1],9,Vector2i(17,0))
		backgroud.set_cell(0,cordtab[2],9,Vector2i(18,0))
		backgroud.set_cell(0,cordtab[3],9,Vector2i(19,0))
		backgroud.set_cell(0,cordtab[4],9,Vector2i(16,1))
		backgroud.set_cell(0,cordtab[5],9,Vector2i(17,1))
		backgroud.set_cell(0,cordtab[6],9,Vector2i(18,1))
		backgroud.set_cell(0,cordtab[7],9,Vector2i(19,1))
		backgroud.set_cell(0,cordtab[8],9,Vector2i(16,2))
		backgroud.set_cell(0,cordtab[9],9,Vector2i(17,2))
		backgroud.set_cell(0,cordtab[10],9,Vector2i(18,2))
		backgroud.set_cell(0,cordtab[11],9,Vector2i(19,2))
		backgroud.set_cell(0,cordtab[12],9,Vector2i(16,3))
		backgroud.set_cell(0,cordtab[13],9,Vector2i(17,3))
		backgroud.set_cell(0,cordtab[14],9,Vector2i(18,3))
		backgroud.set_cell(0,cordtab[15],9,Vector2i(19,3))
		
		door.set_deferred("disabled",true)


func _on_area_2d_body_entered(body):
	if body.name == "player":
		Global.transition_scane = true
		change_scene()
