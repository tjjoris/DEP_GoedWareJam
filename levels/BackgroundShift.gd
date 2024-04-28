extends ParallaxBackground
@export var bg_overworld = preload("res://levels/sprites/_bg_allmage.png")
@export var bg_shadow = preload("res://levels/sprites/_bg_allmage_shadow.png")

@onready var background_sprite: Sprite2D = $ParallaxLayer/BackgroundSprite


func shift_to_shadow():
	if bg_shadow != null && background_sprite:
		background_sprite.texture = bg_shadow
		pass

func shift_to_overworld():
	if bg_overworld != null && background_sprite:
		background_sprite.texture = bg_overworld
		pass
