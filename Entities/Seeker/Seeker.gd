extends KinematicBody2D


var acquire_radius = 30
var player
var move_speed = 35

var velocity = Vector2(move_speed, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity.x = move_speed

	player = get_tree().root.get_node("Root/Player")
	var angle = 0
	if player:
		angle = position.direction_to(player.position).angle()
		
	rotation = lerp_angle(rotation, angle, 0.3 * delta)	
		
	var motion = (velocity*delta)
	motion = motion.rotated(rotation)
	
	var collision = move_and_collide(motion)
	if collision:
		if collision.collider.name == "Spikes":
			# immediately turn around
			rotation = rotation + 180


func _on_Timer_timeout():
	pass
