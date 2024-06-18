extends Area2D

@export var speed := 200.00

@onready var Ani := $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D


@onready var Me : Callable = Callable(self,"_on_player_position")

@onready var boom= false

@onready var player = get_tree().get_nodes_in_group("Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	Ani.play("Fly")
	collision_shape_2d.set_deferred("disabled",false)
	player=player[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	if boom == false:
		look_at(player.position)
		position = position.move_toward(player.position,delta*speed)
	
	


func _on_body_entered(body):
	if boom==false:
		Ani.play("Boom")
		boom = true
	else:
		if body.name == "player":
			body.take_damage(15)




func _on_animation_player_animation_finished(anim_name):
	queue_free()


func _on_timer_timeout():
	if boom==false:
		Ani.play("Boom")
		boom = true
