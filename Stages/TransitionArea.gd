extends Area2D

export (PackedScene) var next_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TransitionArea_body_entered(body):
	if body.name == "Player":
		if next_scene:
			var ns_instance = next_scene.instance()
			get_tree().root.call_deferred("add_child", ns_instance)
			get_parent().queue_free()
			var player = get_tree().root.get_node("Root/Player")
			player.next_stage()
		
