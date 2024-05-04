extends ReferenceRect

@onready var sample_count_text: Label = %SampleCountText
var samples_in_level: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("collectable_value_changed", self.update_collectable_score)
	var samples = get_tree().get_nodes_in_group("IsCollectableSample")
	if samples:
		samples_in_level = samples.size()
	sample_count_text.text = str(GameManager.collectable_score)
	update_collectable_score(0)


func update_collectable_score(score: int):
	sample_count_text.text = str(score) + "/" + str(samples_in_level)
	
