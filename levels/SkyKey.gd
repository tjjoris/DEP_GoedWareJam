extends Sprite2D

@onready var hud_portals_timewarp_chamber: Sprite2D = $"../HudPortalsTimewarpChamber"



func _on_area_2d_body_entered(body: Node2D) -> void:
	print("body entered")
	hud_portals_timewarp_chamber.visible = true
	hud_portals_timewarp_chamber.set_process(true)
	
	queue_free()
	pass # Replace with function body.
