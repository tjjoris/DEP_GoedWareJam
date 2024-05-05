extends ParallaxBackground
const BACKGROUND_NORMALWORLD_0 = preload("res://levels/background/overworld/background_normalworld_0.png")
const BACKGROUND_NORMALWORLD_1 = preload("res://levels/background/overworld/background_normalworld_1.png")
const BACKGROUND_NORMALWORLD_2 = preload("res://levels/background/overworld/background_normalworld_2.png")
const BACKGROUND_NORMALWORLD_3 = preload("res://levels/background/overworld/background_normalworld_3.png")
const BACKGROUND_SHADOWWORLD_0 = preload("res://levels/background/shadowworld/background_shadowworld_0.png")
const BACKGROUND_SHADOWWORLD_1 = preload("res://levels/background/shadowworld/background_shadowworld_1.png")
const BACKGROUND_SHADOWWORLD_2 = preload("res://levels/background/shadowworld/background_shadowworld_2.png")
const BACKGROUND_SHADOWWORLD_3 = preload("res://levels/background/shadowworld/background_shadowworld_3.png")

@onready var background_sprite_0: Sprite2D = %BackgroundSprite_0
@onready var background_sprite_1: Sprite2D = %BackgroundSprite_1
@onready var background_sprite_2: Sprite2D = %BackgroundSprite_2
@onready var background_sprite_3: Sprite2D = %BackgroundSprite_3


func shift_to_shadow():
	if background_sprite_0:
		background_sprite_0.texture = BACKGROUND_SHADOWWORLD_0
		background_sprite_1.texture = BACKGROUND_SHADOWWORLD_1
		background_sprite_2.texture = BACKGROUND_SHADOWWORLD_2
		background_sprite_3.texture = BACKGROUND_SHADOWWORLD_3
		pass

func shift_to_overworld():
	if background_sprite_0:
		background_sprite_0.texture = BACKGROUND_NORMALWORLD_0
		background_sprite_1.texture = BACKGROUND_NORMALWORLD_1
		background_sprite_2.texture = BACKGROUND_NORMALWORLD_2
		background_sprite_3.texture = BACKGROUND_NORMALWORLD_3
		pass
