extends CanvasLayer

@onready var message_label = %MessageLabel
@onready var portrait_texture = %PortraitTexture



var current_session:DialogueSession

func continue_dialogue():
	if current_session == null:
		return
	current_session.continue_dialogue()
	


func set_dialogue_label(message:String):
	message_label.text = message
	
func set_dialogue_texture(texture:Texture2D):
	portrait_texture.texture = texture
