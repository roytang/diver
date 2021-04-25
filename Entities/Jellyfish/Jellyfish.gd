extends KinematicBody2D


export var facing_right = true
export var move_speed = 35

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if facing_right:
		velocity.x = move_speed
		$AnimatedSprite.set_flip_h(false)
	else:
		velocity.x = -move_speed
		$AnimatedSprite.set_flip_h(true)
		
	var motion = (velocity*delta)
	var collision = move_and_collide(motion)
	if collision:
		if collision.collider.name == "Spikes":
			# immediately turn around
			facing_right = !facing_right


