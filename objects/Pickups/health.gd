extends Area2D

func _on_body_entered(body):
	if(body.has_method("get_health")):
		body.get_health()
		queue_free()