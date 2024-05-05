extends Button

func _on_button_pressed():
	#the function below works to load a specific scene.
	#LevelLoader2.goto_scene("res://levels/level_luke2.tscn")
	
	#the function below works to load the next scene in the level_loader2 levels array
	LevelLoader.goto_next_scene()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


