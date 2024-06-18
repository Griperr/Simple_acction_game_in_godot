extends Area2D

@onready var Ani = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Ani.play("animation")
	var anim_name = "animation"
	





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Ani.get_current_animation()!="animation":
		pass




	


func _on_animation_player_animation_finished(anim_name):
	queue_free()


func _on_body_entered(body):
	if body.name == 'player':
		body.take_damage(10)
		#queue_free()
