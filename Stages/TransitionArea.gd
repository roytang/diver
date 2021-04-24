extends Area2D

export (PackedScene) var next_scene

var can_transition = 0
var transition_cooldown = 500

func _ready():
	var now = OS.get_ticks_msec()
	can_transition = now + transition_cooldown

func _on_TransitionArea_body_entered(body):
	if body.name == "Player":
		if next_scene:
			
			# prevent immediate transition chain
			var now = OS.get_ticks_msec()
			if now > can_transition:
				print("Transitioning!")
				
				var player = get_tree().root.get_node("Root/Player")
				player.next_stage()
				
				var ns_instance = next_scene.instance()
				get_tree().root.call_deferred("add_child", ns_instance)
				get_parent().queue_free()
				
				# also remove all temporary objects attached to root, i.e. bubbles
				var root = get_tree().root.get_node("Root")
				for N in root.get_children():
					if N.is_in_group("Temporary"):
						N.queue_free()
		
