extends Area2D

@onready var player = get_node("/root/world/player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = self.global_position.angle_to_point(player.global_position)
