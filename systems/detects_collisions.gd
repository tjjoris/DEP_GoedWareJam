extends Area2D

func _ready():
	# Đăng ký signal.
	connect("body_entered", self._on_body_entered)

func _on_body_entered(body):
	# In ra thông báo khi một vật thể va chạm.
	print("Một vật thể đã va chạm!")
