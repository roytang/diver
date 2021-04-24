extends KinematicBody2D


var gravity = 80
var walkspeed = 60
var bounce = 90
var bounce_cooldown = 1000
var next_bounce = 0
var bounce_to = 0
var bounce_time = 800
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	if Input.is_action_pressed("ui_left"):
		velocity.x = -walkspeed
		$AnimatedSprite.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		velocity.x = walkspeed
		$AnimatedSprite.set_flip_h(false)
	else:
		velocity.x = 0

	if Input.is_action_pressed("ui_accept"):
		var now = OS.get_ticks_msec()
		if now >= next_bounce:
			velocity.y = -bounce
			next_bounce = now + bounce_cooldown
			bounce_to = now + bounce_time
		
func _physics_process(delta):
	var now = OS.get_ticks_msec()
	if now >= bounce_to:
		velocity.y = gravity
	else:
		velocity.y = -bounce
	get_input()
	var motion = (velocity*delta)
	var collision = move_and_collide(motion)	
	if collision:
		if collision.collider.name == "Spikes":
			# YOU'LL DIE!
			$CollisionShape2D.disabled
			set_process(false)
			$AnimationPlayer.play("Death")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		get_tree().queue_delete(self)
