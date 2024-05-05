class_name PhaseShifter
extends Node2D
#@export var is_shifted: bool = false;
@onready var tile_map: TileMap = $"../../TileMap"
@onready var parallax_background: ParallaxBackground = $"../ParallaxBackground"
@export var start_shifted = false

@export var sfx_phase_to_shadow = preload("res://audio/sfx/phase_shadow_00.wav")
@export var sfx_phase_to_overworld = preload("res://audio/sfx/phase_overworld.wav")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# on level load, inverts phase so that it shifts into the current phase
	if start_shifted:
		GameManager.is_shifted = false
	else:
		GameManager.is_shifted = true
	phase_shift()


func phase_shift() -> void:
	# swap between Overworld and Shadow states
		# TileMap Layer 0 = Shadow
		# TileMap Layer 1 = Overworld
		if GameManager.is_shifted:
			shift_to_overworld()
		else:
			shift_to_shadow()


func shift_to_shadow() -> void:
	GameManager.is_shifted = true
	
	#swap tilemap layers
	tile_map.set_layer_enabled(0, true)
	tile_map.set_layer_enabled(1, false)
	parallax_background.shift_to_shadow()
	
	call_deferred("shift_groups")



func shift_to_overworld() -> void:
	GameManager.is_shifted = false
	
	#swap tilemap layers
	tile_map.set_layer_enabled(0, false)
	tile_map.set_layer_enabled(1, true)
	parallax_background.shift_to_overworld()
	
	call_deferred("shift_groups")


func shift_groups():
	get_tree().call_group("CanPhase", "do_phase_change", GameManager.is_shifted)


func _on_player_phase_shift() -> void:
	phase_shift()


func _on_pressure_plate_body_entered(_body: Node2D) -> void:
	phase_shift()
