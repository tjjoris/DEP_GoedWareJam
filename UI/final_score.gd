extends ReferenceRect

@onready var samples_score: Label = %SamplesScore


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_tally_score()


func _on_tally_score() -> void:
	samples_score.text = str(GameManager.total_collectables) + "/" + str(GameManager.max_total_collectables)


func _on_return_to_menu() -> void:
	LevelLoader.load_scene(0)
