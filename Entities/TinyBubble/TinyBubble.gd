extends Sprite


var velocity = Vector2(0, -5)
var wisp = false
var wisp_velocity = -50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	
	if wisp:
		position.y = position.y + wisp_velocity * delta
		if position.y <= 0:
			queue_free()
	else:
		var motion = (velocity*delta)
		position.y = position.y + motion.y


func _on_Timer_timeout():
	if not wisp:
		queue_free()
