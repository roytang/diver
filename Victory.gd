extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().root.get_node("Root").queue_free()
		get_tree().change_scene("res://Splash.tscn")
		get_tree().paused = false
