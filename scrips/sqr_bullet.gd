extends Area2D

@export var speed := 200.00

@onready var Ani := $AnimationPlayer

@onready var Me : Callable = Callable(self,"_on_player_position")



@onready var player = get_tree().get_nodes_in_group("Player")  #get_node("/root/world/player")

@onready var target_lock=false
@onready var exited_screen_time: float = 0.0
@onready var current_time=0
var time_to_live: float = 3.0



var movement_vector := Vector2.ZERO
var target_vec : Vector2




func  _ready():
	
	player=player[0]
	
	look_at(player.global_position)
	
	target_vec = player.global_position - self.global_position
	movement_vector = target_vec.normalized()
	
	Ani.play("Animation")
	
	
	





func _physics_process(delta):
	Node.PROCESS_MODE_ALWAYS
	global_position += movement_vector*speed*delta
	#position = position.move_toward(movement_vector,delta*speed)
	
	
	
	
	#global_position.x = move_toward(player.x,speed,speed)
	#.rotated(rotation)
	


#func check_lifetime(delta):
	


func _on_visible_on_screen_enabler_2d_screen_exited():
	#pass
	queue_free()
	#exited_screen_time=current_time
	


func _on_body_entered(body):
	if body.name == 'player':
		body.take_damage(5)
		queue_free()
	








	
