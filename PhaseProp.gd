extends Node2D

@onready var overworld_sprite: Sprite2D = $OverworldSprite
@onready var shadow_sprite: Sprite2D = $ShadowSprite



func do_phase_change(_entering_shadow_realm: bool):
	if GameManager.is_shifted:
		shadow_sprite.visible = true
		overworld_sprite.visible = false
	else:
		shadow_sprite.visible = false
		overworld_sprite.visible = true
