extends Marker2D

var emeny = preload("res://objects/enemies/emeny_2.tscn")

@onready var spawn_berth = $"SpawnBerth"

func spawn():
	var fresh_child = emeny.instantiate()
	fresh_child.linear_velocity = Vector2(randf()-0.5, randf()-0.5).normalized() * 50.0
	add_child(fresh_child)

func _on_timer_timeout():
	if !spawn_berth.has_overlapping_bodies():
		spawn()
	#if spawn_berth.has_overlapping_bodies():
		#spawn_berth.connect("area_exited", _area_exited)
	#else:
		#spawn()

#func _area_exited():
	#if !spawn_berth.has_overlapping_bodies():
		#spawn()
		#spawn_berth.disconnect("area_exited", _area_exited)
