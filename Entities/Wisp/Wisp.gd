extends AnimatedSprite


var velocity = Vector2(0, -50)

func _physics_process(delta):
	
	var motion = (velocity*delta)
	position.y = position.y + motion.y
	
	if position.y < 0:
		queue_free()
