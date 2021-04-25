extends Area2D

var velocity = Vector2(0, -15)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	var motion = (velocity*delta)
	position.y = position.y + motion.y


func _on_AirBubble_body_entered(body):
	if body.name == "Player":
		body.get_bubble()
	queue_free()
	get_tree().root.get_node("Root/SoundPop").play()
