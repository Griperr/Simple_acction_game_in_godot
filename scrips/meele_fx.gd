extends Area2D


@onready var Ani = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	Ani.play("Meele")
	





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Ani.get_current_animation()!="Meele":
		queue_free()





func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage_meele()
		queue_free()
