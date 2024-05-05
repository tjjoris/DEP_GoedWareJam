extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("off")

func _on_body_entered(_body: Node2D) -> void:
	animated_sprite.play("on")

func _on_body_exited(_body: Node2D) -> void:
	animated_sprite.play("off")
