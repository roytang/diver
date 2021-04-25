extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Victory.set_process_input(false)
	pass # Replace with function body.


func victory():
	get_tree().root.get_node("Root/Player").visible = false
	$Victory.popup()
	$Victory.set_process_input(true)
	get_tree().paused = true
	$Victory/Fanfare.play()
