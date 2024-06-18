extends Node


var current_scene ="world"
var new_scene = "level_1"


var transition_scane = false

func finish_change():
	if transition_scane == true:
		transition_scane = false
		current_scene = new_scene
		
		if current_scene=="level_1":
			new_scene = "level_2"
		elif current_scene== "level_2":
			new_scene = "boss_level" 
