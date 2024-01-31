extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true

func _input(event):
	if event.is_action("primary_fire") or event.is_action("secondary_fire"):
		get_tree().paused = false
		queue_free()
