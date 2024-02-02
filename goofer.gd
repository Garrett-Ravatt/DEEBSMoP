extends Node

signal goof

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	goof.emit()
