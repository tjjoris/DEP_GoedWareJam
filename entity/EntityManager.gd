extends CharacterBody2D

##overworld behaviour
##shadowrealm behaviour

var _in_shadow_realm: bool

func _on_phase_changed(entering_shadow_realm: bool):
	# check to see if state is different
	if _in_shadow_realm != entering_shadow_realm:
		do_phase_change(entering_shadow_realm)
	pass


func do_phase_change(entering_shadow_realm: bool):
	_in_shadow_realm = entering_shadow_realm
	if _in_shadow_realm:
		enter_shadow_realm()
		

func enter_shadow_realm():
	print(name + " entered the shadow realm.")
	pass

func enter_overworld():
	print(name + " entered the overworld.")
	pass
