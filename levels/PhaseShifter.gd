extends Node2D
@export var is_shifted: bool = false;
@onready var tile_map: TileMap = $"../../TileMap"
@onready var parallax_background: ParallaxBackground = $"../ParallaxBackground"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# on level load, inverts phase so that it shifts into the current phase
	is_shifted = not is_shifted
	phase_shift()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("phase_shift"):
		phase_shift()

func phase_shift() -> void:
	# swap between Overworld and Shadow states
		# TileMap Layer 0 = Shadow
		# TileMap Layer 1 = Overworld
		if is_shifted:
			shift_to_overworld()
		else:
			shift_to_shadow()


func shift_to_shadow() -> void:
	is_shifted = true
	
	#swap tilemap layers
	tile_map.set_layer_enabled(0, true)
	tile_map.set_layer_enabled(1, false)
	parallax_background.shift_to_shadow()
	
	shift_groups()



func shift_to_overworld() -> void:
	is_shifted = false
	
	#swap tilemap layers
	tile_map.set_layer_enabled(0, false)
	tile_map.set_layer_enabled(1, true)
	parallax_background.shift_to_overworld()
	
	shift_groups()


func shift_groups():
	get_tree().call_group("CanPhase", "do_phase_change", is_shifted)
