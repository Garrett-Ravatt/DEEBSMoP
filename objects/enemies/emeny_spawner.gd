extends Marker2D

var emeny = preload("res://objects/enemies/emeny_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	add_child(emeny.instantiate())
