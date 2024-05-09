extends ReferenceRect

@onready var sfx_hud: AudioStreamPlayer = %SFX_HUD
@export var sample_collect = preload("res://audio/sfx/SampleCollection_00.wav")
@onready var sample_count_text: Label = %SampleCountText
var samples_in_level: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	GameManager.connect("collectable_value_changed", self.update_collectable_score)
	var samples = get_tree().get_nodes_in_group("IsCollectableSample")
	if samples:
		samples_in_level = samples.size()
	update_collectable_score(0)


func update_collectable_score(score: int):
	if sfx_hud and sample_collect and score != 0:
		sfx_hud.stream = sample_collect
		sfx_hud.play()
	sample_count_text.text = str(score) + "/" + str(samples_in_level)
	
