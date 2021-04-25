extends Sprite


var velocity = Vector2(0, -5)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	var motion = (velocity*delta)
	position.y = position.y + motion.y


func _on_Timer_timeout():
	queue_free()
