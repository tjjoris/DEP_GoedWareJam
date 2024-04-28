extends CharacterBody2D

var _in_shadow_realm: bool = false

## Overworld/ShadowRealm states
@export var overworld_state: Node2D = null
@export var shadow_realm_state: Node2D = null

func _ready() -> void:
	if overworld_state == null:
		overworld_state = $OverworldState
		if overworld_state == null:
			print(name + " could not find OverworldState Node")
	if shadow_realm_state == null:
		shadow_realm_state = $ShadowRealmState
		if shadow_realm_state == null:
			print(name + " could not find ShadowRealm Node")

func _on_phase_changed(entering_shadow_realm: bool):
	# check to see if state is different before phase change
	if _in_shadow_realm != entering_shadow_realm:
		do_phase_change(entering_shadow_realm)
	pass


func do_phase_change(entering_shadow_realm: bool):
	_in_shadow_realm = entering_shadow_realm
	
	toggle_active_nodes()
		
	if _in_shadow_realm:
		enter_shadow_realm()
	else:
		enter_overworld()

func toggle_active_nodes():
	#define overworld state
	var is_overworld_active = not _in_shadow_realm
	
	if overworld_state == null || shadow_realm_state == null:
		print(name + " does not have overworld/shadow states")
		pass
	shadow_realm_state.set_process(_in_shadow_realm)
	shadow_realm_state.visible = _in_shadow_realm
	overworld_state.set_process(is_overworld_active)
	overworld_state.visible = is_overworld_active

func enter_shadow_realm():
	#print(name + " entered the shadow realm.")
	pass

func enter_overworld():
	#print(name + " entered the overworld.")
	pass	

