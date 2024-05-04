extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.death()
	else:
		# kill any non-player entities that fall into the kill floor so they aren't falling forever.
		body.queue_free()
