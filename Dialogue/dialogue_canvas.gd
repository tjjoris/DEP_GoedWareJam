extends CanvasLayer

@onready var message_label: RichTextLabel = %MessageLabel
@onready var portrait_texture: TextureRect = %PortraitTexture
@onready var current_session: DialogueSession = $DialogueSession1

func _input(_event):
	if Input.is_action_just_pressed("continue_dialogue"):
		continue_dialogue()

func continue_dialogue():
	if current_session == null:
		return
	current_session.continue_dialogue()


func set_dialogue_label(message:String):
	message_label.text = message
	
func set_dialogue_texture(texture:Texture2D):
	portrait_texture.texture = texture
