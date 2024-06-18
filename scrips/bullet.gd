extends Area2D
class_name Bullet


@export var speed := 600.00

@onready var Ani := $AnimationPlayer
@onready var enemy = null

var movement_vector := Vector2(1,0)

func  _process(delta):
	Ani.play("Animation")

func _physics_process(delta):
	global_position += movement_vector*speed*delta





func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage_gun()
		queue_free()
