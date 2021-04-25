extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Player_breath(var player):
	rect_size.y = 126 * player.oxygen / 100
	rect_position.y = 17 + 126 - rect_size.y
