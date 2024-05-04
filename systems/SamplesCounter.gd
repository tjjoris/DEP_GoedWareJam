extends ReferenceRect

@onready var sample_count_text: Label = %SampleCountText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("collectable_value_changed", self.update_collectable_score)
	sample_count_text.text = str(GameManager.collectable_score)


func update_collectable_score(score: int):
	sample_count_text.text = str(score)
	
