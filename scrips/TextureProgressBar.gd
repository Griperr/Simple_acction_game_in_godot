extends TextureProgressBar

@onready var player = $"../../player"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	update()
	player.health_change.connect(update)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = player.hp
