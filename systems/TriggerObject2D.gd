extends Area2D

@export var destroyed_on_contact = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Player has collected a sample!")
		queue_free()
