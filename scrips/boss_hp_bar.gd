extends TextureProgressBar

@onready var owl = $"../../Owl"



# Called when the node enters the scene tree for the first time.
func _ready():
	update()
	max_value = owl.max_hp
	owl.health_change.connect(update)
	owl.player_deteced.connect(player_detected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = owl.current_hp
	if value<=0:
		visible=false

func player_detected():
	visible=true
