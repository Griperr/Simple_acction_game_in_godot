extends CharacterBody2D

signal bullet_shot(Bullet)
signal meele_stike(meele_fx)
signal player_position(sqr_bullet)
signal health_change
 
@export var max_speed = 400
@export var acceleration = 60
@export var firerate = 0.2
@export var doge_cd = 0.8
@export var hp = 100


@onready var can_shoot = true
@onready var can_doge = true
@onready var can_move = true
@onready var can_attack = true
@export var can_be_hurt = true

@export var bullet: PackedScene

@onready var Ani = $AnimationPlayer
@onready var ani : AnimationTree = $AnimationTree
@onready var anistm  = $AnimationTree.get("parameters/playback")
var mosp
var plp
var player_pos
@onready var muzzle = $muzzle


var bullet_scene = preload("res://scenes/bullet.tscn")
var meele_scene = preload("res://scenes/meele_fx.tscn")

func _ready():
	ani.active = true
	can_be_hurt = true
	

func  _physics_process(delta):
	var direction: Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down").normalized()
	
	
	if direction and can_move:
		velocity.x = move_toward(velocity.x,max_speed*direction.x, acceleration)
		velocity.y = move_toward(velocity.y,max_speed*direction.y, acceleration)
	else:
		velocity = Vector2.ZERO
	
	
	move_and_slide()
	
		
		
func _process(delta):
	update_ani_parameters()
	die()
	mosp = get_global_mouse_position()
	plp = $Sprite2D.global_position
	#print(position)
	
	
	
	
	
func  update_ani_parameters():
	if velocity == Vector2.ZERO:
		ani["parameters/conditions/idle"] = true      #Ruch
		ani["parameters/conditions/is_run"] = false
	else :
		ani["parameters/conditions/idle"] = false
		ani["parameters/conditions/is_run"] = true
	if Input.is_action_just_pressed("ui_doge"):      #Unik
		if can_doge:
			can_move = true
			can_doge = false
			ani["parameters/conditions/is_doge"] = true
			ani["parameters/conditions/is_meele"] = false
			await  get_tree().create_timer(doge_cd).timeout
			can_doge = true 
		
	else:
		ani["parameters/conditions/is_doge"] = false
		
	if Input.is_action_just_pressed("ui_meele") and can_attack:
		can_attack = false
		ani["parameters/conditions/is_meele"] = true    #Atak
		can_move =false		
		if mosp < plp:
			$Sprite2D.flip_h=true
		else:
			$Sprite2D.flip_h=false
			
		meele_attack()
		
				
	else:
		ani["parameters/conditions/is_meele"] = false 
		
	if Input.is_action_pressed("ui_shoot") and ani["parameters/conditions/is_doge"]==false: #Strzał
		ani["parameters/conditions/idle"] = false
		ani["parameters/conditions/is_run"] = false
		if mosp < plp:
			$Sprite2D.flip_h=true
		else:
			$Sprite2D.flip_h=false
		anistm.travel("shooting")
		if can_shoot:
			can_shoot = false
			shoot_bullet()
			await get_tree().create_timer(firerate).timeout
			can_shoot = true
	
		
		
	
func shoot_bullet():
		
	var b = bullet_scene.instantiate()
	if  $Sprite2D.flip_h==true:
		muzzle.position.x = -30
		b.scale.x = -1
		b.movement_vector = Vector2(-1,0)
	else:
		muzzle.position.x = 30
	b.global_position = muzzle.global_position
	
	emit_signal("bullet_shot",b)
		
		
	
func meele_attack():
	var m = meele_scene.instantiate()
	if $Sprite2D.flip_h == true:
		muzzle.position.x = -30
		m.scale.x = -1
	else:
		muzzle.position.x = 30
		m.scale.x = 1 
	m.global_position = muzzle.global_position
	emit_signal("meele_stike",m)
	
		


func take_damage(amount):
	if can_be_hurt:
		hp -= amount
		emit_signal("health_change")


func die():
	if hp <=0:
		get_tree().reload_current_scene()



func _on_animation_tree_animation_finished(meele):
	can_move = true
	can_attack = true



