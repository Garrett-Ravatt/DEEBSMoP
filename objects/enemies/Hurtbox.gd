extends Area2D

func _on_body_entered(body):
	if body.has_method("get_hurt"):
		body.get_hurt()
