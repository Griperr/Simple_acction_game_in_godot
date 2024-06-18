extends CharacterBody2D

const  speed_devider = 35

signal ele_meele_strike(ele_meele)

var attack_rate = 2
var after_attack_cd = 1.3

@export var maxhp = 20

@onready var currenthp = maxhp

@onready var can_see_player = false

@onready var player = null

@onready var can_attack = true

@onready var can_move = true

var distance
@onready var ani : AnimationTree = $AnimationTree
@onready var muzzle = $muzzle
@onready var anistm  = $AnimationTree.get("parameters/playback")
@onready var hpbar = $hpbar

var meele_scene = preload("res://scenes/ele_meele.tscn")


func  _ready():
	hpbar.max_value = maxhp
	hpbar.value = maxhp

func _process(delta):
	if currenthp<=0:
		queue_free()
	if !can_move:
		await get_tree().create_timer(after_attack_cd).timeout
		can_move = true

func _physics_process(delta):
	if can_see_player and can_move:
		if(player.position.x - position.x)>0:
				$Sprite2D.flip_h=true
				muzzle.position.x = 26
		else:
				$Sprite2D.flip_h=false	
				muzzle.position.x = -26
		
		if abs(global_position.x - player.global_position.x) > 45 or abs(global_position.y - player.global_position.y) > 45:
			ani["parameters/conditions/is_move"]=true
			ani["parameters/conditions/is_attack"] = false
			ani["parameters/conditions/is_idlle"] = false
			position+=(player.position - position)/speed_devider
			move_and_slide()
		else : #Attack
			if can_attack:
				can_attack = false
				can_move = false
				ani["parameters/conditions/is_attack"] = true
				ani["parameters/conditions/is_move"] = false
				ani["parameters/conditions/is_idlle"] = false
				meele_attack()
						
				await get_tree().create_timer(attack_rate).timeout
				can_attack = true	
		
	else : #iddle
		ani["parameters/conditions/is_attack"] = false
		ani["parameters/conditions/is_move"] = false
		ani["parameters/conditions/is_idlle"] = true

func  update_hpbar():
	hpbar.value = currenthp

func  damage_gun():
	currenthp -= 1
	update_hpbar()
func damage_meele():
	currenthp -= 10
	update_hpbar()

func _on_area_2d_body_entered(body):
	if body.name == "player":
		player = body
		can_see_player = true
	



func _on_area_2d_body_exited(body):
	player =null
	can_see_player = false
	

func meele_attack():
	var m = meele_scene.instantiate()
	if $Sprite2D.flip_h == true:
		m.scale.x = -1
	else:
		m.scale.x = 1 
	m.global_position = muzzle.global_position
	emit_signal("ele_meele_strike",m)
	
	





	


func _on_animation_tree_animation_finished(anim_name):
	anistm.travel("Stop")
	ani["parameters/conditions/is_attack"] = false
	ani["parameters/conditions/is_move"] = false
	ani["parameters/conditions/is_idlle"] = true
	
