extends Sprite

var bubble_scene = preload("res://Entities/AirBubble/AirBubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func bubble():
	var bubble = bubble_scene.instance()
	bubble.position = position
	bubble.position.y = bubble.position.y - 32
	get_tree().root.get_node("Root").add_child(bubble)
	
func _on_Timer_timeout():
	bubble()


func _on_Timer2_timeout():
	bubble()
