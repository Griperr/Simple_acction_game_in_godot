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
@onready var elephant = $elephant
@onready var elephant_2 = $elephant2
@onready var elephant_3 = $elephant3
@onready var elephant_4 = $elephant4



@onready var enemies = get_tree().get_nodes_in_group("Enemy")
@onready var enemycount = enemies.size()
@onready var cordtab=[Vector2i(74,-65),Vector2i(75,-65),Vector2i(76,-65),Vector2i(77,-65),
Vector2i(74,-66),Vector2i(75,-66),Vector2i(76,-66),Vector2i(77,-66),
Vector2i(74,-67),Vector2i(75,-67),Vector2i(76,-67),Vector2i(77,-67),
Vector2i(74,-68),Vector2i(75,-68),Vector2i(76,-68),Vector2i(77,-68)]


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	Global.current_scene="level_1"
	
	player.connect("bullet_shot", _on_player_bullet_shot)
	player.connect("meele_stike", _on_player_meele)
	squirrel.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_2.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_3.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_4.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	squirrel_5.connect("shoot_sqr_bullet",_on_shoot_sqr_bullet)
	elephant.connect("ele_meele_strike",_on_ele_meele_strike)
	elephant_2.connect("ele_meele_strike",_on_ele_meele_strike)
	elephant_3.connect("ele_meele_strike",_on_ele_meele_strike)
	elephant_4.connect("ele_meele_strike",_on_ele_meele_strike)
	


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





func _on_area_2d_body_entered(body):
	if body.name == "player":
		Global.transition_scane = true
		change_scene()



func  change_scene():
	if Global.transition_scane==true:
		if Global.current_scene == "level_1":
			get_tree().call_deferred("change_scene_to_file","res://scenes/level_2.tscn")

func stagecleared():
	if enemycount == 0:
		backgroud.set_cell(0,cordtab[0],9,Vector2i(0,3))
		backgroud.set_cell(0,cordtab[1],9,Vector2i(1,3))
		backgroud.set_cell(0,cordtab[2],9,Vector2i(2,3))
		backgroud.set_cell(0,cordtab[3],9,Vector2i(3,3))
		backgroud.set_cell(0,cordtab[4],9,Vector2i(0,2))
		backgroud.set_cell(0,cordtab[5],9,Vector2i(1,2))
		backgroud.set_cell(0,cordtab[6],9,Vector2i(2,2))
		backgroud.set_cell(0,cordtab[7],9,Vector2i(3,2))
		backgroud.set_cell(0,cordtab[8],9,Vector2i(0,1))
		backgroud.set_cell(0,cordtab[9],9,Vector2i(1,1))
		backgroud.set_cell(0,cordtab[10],9,Vector2i(2,1))
		backgroud.set_cell(0,cordtab[11],9,Vector2i(3,1))
		backgroud.set_cell(0,cordtab[12],9,Vector2i(0,0))
		backgroud.set_cell(0,cordtab[13],9,Vector2i(1,0))
		backgroud.set_cell(0,cordtab[14],9,Vector2i(2,0))
		backgroud.set_cell(0,cordtab[15],9,Vector2i(3,0))
		
		door.set_deferred("disabled",true)
