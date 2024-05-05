extends Node2D

@onready var overworld_sprite: Sprite2D = %OverworldSprite
@onready var shadow_sprite: Sprite2D = %ShadowSprite


func _ready() -> void:
	call_deferred("handle_sprites")

func do_phase_change(_entering_shadow_realm: bool):
	# can be called before node is ready
	if overworld_sprite == null || shadow_sprite == null:
		return
		
	call_deferred("handle_sprites")


func handle_sprites():
	if GameManager.is_shifted:
		shadow_sprite.visible = true
		overworld_sprite.visible = false
	else:
		shadow_sprite.visible = false
		overworld_sprite.visible = true
