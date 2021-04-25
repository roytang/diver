extends ColorRect

var max_depth = 0

func _ready():
	set_process_input(false)
	
func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().root.get_node("Root").queue_free()
		get_tree().change_scene("res://Splash.tscn")

func set_max_depth(max_depth):
	var quote = ""
	if max_depth < 100:
		quote = "Really? Is that the best you can do?"
	elif max_depth < 200:
		quote = "C'mon, my mom can do better than that!"
	elif max_depth < 350:
		quote = "Starting to get the hang of it eh?"
	elif max_depth < 600:
		quote = "You're pretty good a this!"
	elif max_depth < 900:
		quote = "Woah! Are you sure you're not cheating?"
	else:
		quote = "Honestly, I don't know how you got this far!"
	$ScoreLabel.text = "You descended to a depth of " + str(max_depth) + " meters!\n" + quote
