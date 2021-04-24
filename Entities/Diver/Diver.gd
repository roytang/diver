extends KinematicBody2D

signal breath
signal stats_change

var gravity = 80
var walkspeed = 60
var bounce = 90
var bounce_cooldown = 1000
var next_bounce = 0
var bounce_to = 0
var bounce_time = 800
var next_breath = 0
var breath_cooldown = 500
var velocity = Vector2()
var stage_start_position = Vector2()

var oxygen = 100
var gems = 0
var stage = 1
var lives = 3

var tiny_bubble_scene = preload("res://Entities/TinyBubble/TinyBubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	stage_start_position = position
	emit_signal("stats_changed", self)

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
		
	if now >= next_breath:
		next_breath = now + breath_cooldown
		oxygen = oxygen - 1
		
		# emit a bubble for flavor
		var bubble = tiny_bubble_scene.instance()
		bubble.position = position
		get_tree().root.get_node("Root").add_child(bubble)
		
		emit_signal("breath", self)
		
		
	get_input()
	var motion = (velocity*delta)
	var collision = move_and_collide(motion)	
	if collision:
		if collision.collider.name == "Spikes":
			# YOU'LL DIE!
			set_process(false)
			$AnimationPlayer.play("Death")
		elif collision.collider.is_in_group("Enemies"):
			# YOU'LL DIE!
			set_process(false)
			$AnimationPlayer.play("Death")
		elif "AirBubble" in collision.collider.name:
			oxygen = clamp(oxygen + 25, 0, 100)
			emit_signal("breath", self)
			collision.collider.queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		if lives > 0:
			lives = lives - 1
			emit_signal("stats_change", self)
			# move back to the stage start position
			position = stage_start_position
			rotation_degrees = 0
			scale = Vector2(1, 1)
		else:
			# TODO Death, game over, whatever
			get_tree().queue_delete(self)

func add_gem():
	gems = gems + 1
	emit_signal("stats_change", self)

func next_stage():
	stage = stage + 1
	position.y = 0
	stage_start_position = position
	emit_signal("stats_change", self)
