extends CanvasLayer
@onready var rich_text_label = %RichTextLabel
@onready var sprite_2d = %Sprite2D
var current_session:DialogueSession

func continue_dialogue():
	if current_session == null:
		return
	current_session.continue_dialogue()
	


func set_dialogue_label(message:String):
	rich_text_label.text = message
	
func set_dialogue_texture(texture:Texture2D):
	sprite_2d.texture = texture
