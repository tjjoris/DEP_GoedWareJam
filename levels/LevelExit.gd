extends Sprite2D
@onready var hud_portals_timewarp_chamber: Sprite2D = $"."


func _ready() -> void:
	hud_portals_timewarp_chamber.visible = false
	hud_portals_timewarp_chamber.set_process(false)


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	queue_free()
