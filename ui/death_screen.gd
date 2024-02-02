extends CanvasLayer

@onready var label = $"Control/Label"

func _ready():
	visible = false
	label.modulate.a = 0

func _process(delta):
	if visible:
		label.modulate.a = label.modulate.a + 0.01

func _on_death():
	visible = true
	get_tree().paused = true
	


func _on_button_pressed():
	get_tree().change_scene_to_file("res://screens/funny.tscn")
