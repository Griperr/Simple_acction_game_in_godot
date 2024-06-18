extends CharacterBody2D


var player = null
var firerate = 0.3
const  speed_devider = 40

signal shoot_sqr_bullet(sqr_bullet)

var can_shoot = true

@onready var see_player = false
@onready var ani : AnimationTree = $AnimationTree
@onready var anistm  = $AnimationTree.get("parameters/playback")
@onready var muzzle = $muzzle
@onready var hpbar = $hpbar


@export var maxhp = 10
@onready var currenthp = maxhp

var bullet_scene = preload("res://scenes/sqr_bullet.tscn")


func  _ready():
	hpbar.value = maxhp

func _process(delta):
	if currenthp<=0:
		queue_free()

func _physics_process(delta):
	if see_player:
		if(player.position.x - position.x)>0:
				$Sprite2D.flip_h=true
				muzzle.position.x = 25
		else:
				$Sprite2D.flip_h=false
				muzzle.position.x = -25
		if abs(position - player.position) > Vector2(250,250):
			ani["parameters/conditions/is_move"] = true
			ani["parameters/conditions/is_attack"] = false
			ani["parameters/conditions/is_idlle"] = false
			position+=(player.position - position)/speed_devider
			move_and_slide()
		
		else : #Attack
			ani["parameters/conditions/is_attack"] = true
			ani["parameters/conditions/is_move"] = false
			ani["parameters/conditions/is_idlle"] = false
			if can_shoot:
				can_shoot = false
				_shoot_sqr_bullet()
				await get_tree().create_timer(firerate).timeout
				can_shoot = true
				
	else : #Idlle
		ani["parameters/conditions/is_attack"] = false
		ani["parameters/conditions/is_move"] = false
		ani["parameters/conditions/is_idlle"] = true


func  update_hpbar():
	hpbar.value = currenthp

func  damage_gun():
	currenthp -= 2
	update_hpbar()
func damage_meele():
	currenthp -= 2
	update_hpbar()

func _on_area_2d_body_entered(body):
	if body.name == "player":
		player = body
		see_player = true





func _on_area_2d_body_exited(body):
	#player = null
	#see_player = false
	pass
	
	
func _shoot_sqr_bullet():
	var b = bullet_scene.instantiate()
	b.global_position = muzzle.global_position
	emit_signal("shoot_sqr_bullet",b)
	
