extends CharacterBody2D


signal health_change
signal player_deteced
signal shoot_sqr_bullet(sqr_bullet)
signal done_shooting
signal done_rockets
signal shoot_rocket

enum  stage{IDLLE,STAGE1,STAGE2,STAGE3}


@onready var ani : AnimationTree = $AnimationTree
@onready var anistm  = $AnimationTree.get("parameters/playback")
@onready var muzzle = $muzzle
@onready var mozzle_r = $mozzle_r
@onready var animation_player = $AnimationPlayer

@export var state: stage

@onready var max_hp = 1000
@onready var current_hp = max_hp

@onready var player = null
@onready var see_player = false
@onready var point_achived = true
@onready var point : Vector2
@onready var can_shot = true
@onready var can_move = true
@onready var times_shoot = 0


@export var speed = 200

var rocket_scene = preload("res://scenes/rocket.tscn")
var bullet_scene = preload("res://scenes/sqr_bullet.tscn")


func _ready():
	randomize()
	state = stage.IDLLE
	self.connect("done_shooting",_on_done_shooting)
	self.connect("done_rockets",_on_done_rockets)

func _physics_process(delta):
	
	match state:
		stage.IDLLE:
			ani["parameters/conditions/is_idlle"]=true
		stage.STAGE1:
			stage1(delta)
				
				
		stage.STAGE2:
			stage2(delta)
		stage.STAGE3:
			stage3(delta)
	
	
	move_and_slide()
	
func _process(delta):
	check_for_death()
	stages()


func  damage_gun():
	current_hp -= 7
	emit_signal("health_change")
	
func  damage_meele():
	current_hp -= 50
	emit_signal("health_change")

func check_for_death():
	if current_hp <= 0:
		queue_free()

func stages():
	if see_player:
		if  current_hp > 800:
			state = stage.STAGE1
		elif current_hp > 500:
			state = stage.STAGE2
		else:
			state = stage.STAGE3
	else:
		state = stage.IDLLE 	


func stage1(delta):
	if round(position)==round(point):
		point_achived=true
	if point_achived:
		can_move = false
		point_achived=false
		
		ani["parameters/conditions/is_riffle"]=true
		ani["parameters/conditions/is_move_l"]=false
		ani["parameters/conditions/is_move_r"]=false
		
		#anistm.travel("Riffle_con")
		await get_tree().create_timer(0.35).timeout
		for x in 5 :
			if can_shot:
				can_shot=false
				_shoot_sqr_bullet()
				await get_tree().create_timer(0.3).timeout
				can_shot = true
				if x==4:
					emit_signal("done_shooting")
		
		
		var pointx = randf_range(player.global_position.x-200,player.global_position.x+200)
		if abs(pointx-player.global_position.x)<100:
			if pointx<=player.global_position.x:
				pointx-=100
			else :
				pointx+=100
		
		if pointx<50:
			pointx = 50
		elif pointx > 2750:
			pointx = 2750
		point.x=pointx
		
		var pointy = randf_range(player.global_position.y+200,player.global_position.y-200)
		if abs(pointy-player.global_position.y)<100:
			if pointy<=player.global_position.y:
				pointy-=100
			else :
				pointy+=100
				
		if pointy<70:
			pointy=70
		elif pointy>580:
			pointy=580
		point.y = pointy
		
		
		#can_move = true
		
	else:
		if point.x < position.x and can_move:
			#anistm.travel("Move_L_con")
			ani["parameters/conditions/is_riffle"]=false
			ani["parameters/conditions/is_move_l"]=true
			ani["parameters/conditions/is_idlle"]=false
		elif point.x > position.x and can_move :
			#anistm.travel("Move_R_con")
			ani["parameters/conditions/is_riffle"]=false
			ani["parameters/conditions/is_move_r"]=true
			ani["parameters/conditions/is_idlle"]=false
		
		if can_move:
			position = position.move_toward(point,delta*speed)


func stage2(delta):
	speed = 350
	
	if round(position)==round(point):
		point_achived=true
	if point_achived:
		can_move = false
		point_achived=false
		
		ani["parameters/conditions/is_riffle"]=true
		ani["parameters/conditions/is_move_l"]=false
		ani["parameters/conditions/is_move_r"]=false
		
		#anistm.travel("Riffle_con")
		await get_tree().create_timer(0.35).timeout #strzelanie
		for x in 8 :
			if can_shot:
				can_shot=false
				_shoot_sqr_bullet()
				await get_tree().create_timer(0.3).timeout
				can_shot = true
				if x==7:
					emit_signal("done_shooting")
					times_shoot+=1
		
		if times_shoot==3:
			times_shoot=0
			can_move=false
			#ani["parameters/conditions/is_idlle"]=false
			ani["parameters/conditions/is_recover"]=false
			ani["parameters/conditions/is_riffle"]=false
			ani["parameters/conditions/is_move_l"]=false
			ani["parameters/conditions/is_move_r"]=false
			ani["parameters/conditions/is_rockets"]=true
			anistm.travel("Rockets")
			
			for x in 4:
				if can_shot:
					can_shot = false
					_shoot_rocket()
					await  get_tree().create_timer(0.2).timeout
					can_shot=true
					if x ==3:
						emit_signal("done_rockets")
			
		
		
		var pointx = randf_range(player.global_position.x-200,player.global_position.x+200)#wybieranie punktu
		if abs(pointx-player.global_position.x)<100:
			if pointx<=player.global_position.x:
				pointx-=100
			else :
				pointx+=100
		
		if pointx<50:
			pointx = 50
		elif pointx > 2750:
			pointx = 2750
		point.x=pointx
		
		var pointy = randf_range(player.global_position.y+200,player.global_position.y-200)
		if abs(pointy-player.global_position.y)<100:
			if pointy<=player.global_position.y:
				pointy-=100
			else :
				pointy+=100
				
		if pointy<70:
			pointy=70
		elif pointy>580:
			pointy=580
		point.y = pointy
		
		
		#can_move = true
		
	else:
		if point.x < position.x and can_move:
			#anistm.travel("Move_L_con")
			ani["parameters/conditions/is_riffle"]=false
			ani["parameters/conditions/is_move_l"]=true
			ani["parameters/conditions/is_idlle"]=false
		elif point.x > position.x and can_move :
			#anistm.travel("Move_R_con")
			ani["parameters/conditions/is_riffle"]=false
			ani["parameters/conditions/is_move_r"]=true
			ani["parameters/conditions/is_idlle"]=false
		
		if can_move:
			position = position.move_toward(point,delta*speed)

func stage3(delta):
	speed = 450
	
	if round(position)==round(point):
		point_achived=true
	if point_achived:
		can_move = false
		point_achived=false
		
		ani["parameters/conditions/is_riffle"]=true
		ani["parameters/conditions/is_move_l"]=false
		ani["parameters/conditions/is_move_r"]=false
		
		#anistm.travel("Riffle_con")
		await get_tree().create_timer(0.35).timeout #strzelanie
		for x in 12 :
			if can_shot:
				can_shot=false
				_shoot_sqr_bullet()
				await get_tree().create_timer(0.2).timeout
				can_shot = true
				if x==11:
					emit_signal("done_shooting")
					times_shoot+=1
		
		if times_shoot==3:
			times_shoot=0
			can_move=false
			#ani["parameters/conditions/is_idlle"]=false
			ani["parameters/conditions/is_recover"]=false
			ani["parameters/conditions/is_riffle"]=false
			ani["parameters/conditions/is_move_l"]=false
			ani["parameters/conditions/is_move_r"]=false
			ani["parameters/conditions/is_rockets"]=true
			anistm.travel("Rockets")
			
			for x in 4:
				if can_shot:
					can_shot = false
					_shoot_rocket()
					await  get_tree().create_timer(0.2).timeout
					can_shot=true
					if x ==3:
						emit_signal("done_rockets")
			
		
		
		var pointx = randf_range(player.global_position.x-200,player.global_position.x+200)#wybieranie punktu
		if abs(pointx-player.global_position.x)<100:
			if pointx<=player.global_position.x:
				pointx-=100
			else :
				pointx+=100
		
		if pointx<50:
			pointx = 50
		elif pointx > 2750:
			pointx = 2750
		point.x=pointx
		
		var pointy = randf_range(player.global_position.y+200,player.global_position.y-200)
		if abs(pointy-player.global_position.y)<100:
			if pointy<=player.global_position.y:
				pointy-=100
			else :
				pointy+=100
				
		if pointy<70:
			pointy=70
		elif pointy>580:
			pointy=580
		point.y = pointy
		
		
		#can_move = true
		
	else:
		if point.x < position.x and can_move:
			#anistm.travel("Move_L_con")
			ani["parameters/conditions/is_riffle"]=false
			ani["parameters/conditions/is_move_l"]=true
			ani["parameters/conditions/is_idlle"]=false
		elif point.x > position.x and can_move :
			#anistm.travel("Move_R_con")
			ani["parameters/conditions/is_riffle"]=false
			ani["parameters/conditions/is_move_r"]=true
			ani["parameters/conditions/is_idlle"]=false
		
		if can_move:
			position = position.move_toward(point,delta*speed)

func _shoot_sqr_bullet():
	var b = bullet_scene.instantiate()
	b.global_position = muzzle.global_position
	emit_signal("shoot_sqr_bullet",b)


func _shoot_rocket():
	var r = rocket_scene.instantiate()
	r.global_position =  mozzle_r.global_position
	emit_signal("shoot_rocket",r)


func _on_area_2d_body_entered(body):
	if body.name=="player":
		player = body
		emit_signal("player_deteced")
		see_player=true



func _on_done_shooting():
	ani["parameters/conditions/is_riffle"]=false
	ani["parameters/conditions/is_idlle"]=true
	ani["parameters/conditions/is_rockets"]=false
	can_move = true

func _on_done_rockets():
	ani["parameters/conditions/is_riffle"]=false
	ani["parameters/conditions/is_idlle"]=false
	ani["parameters/conditions/is_rockets"]=false
	await get_tree().create_timer(5.0).timeout
	ani["parameters/conditions/is_recover"]=true
	can_move = true

func _on_area_2d_2_body_entered(body):
	if body.name=="player":
		body.take_damage(10)




