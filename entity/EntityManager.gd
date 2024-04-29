extends CharacterBody2D

@onready var movement_handler: MovementHandler = $Movement_Handler


## Overworld/ShadowRealm states
@export var overworld_state: Node2D = null
@export var shadow_realm_state: Node2D = null

var _in_shadow_realm: bool = false
var detection_zone: Area2D = null

# possible movement states for entity
enum States {
	WANDER,
	CHASE
}
var _state = null
const _directions: Array = [-1, 1]
var _direction: float = 0
var _target: CharacterBody2D = null;

func _ready() -> void:
	if overworld_state == null:
		overworld_state = $OverworldState
		if overworld_state == null:
			print(name + " could not find OverworldState Node")
	if shadow_realm_state == null:
		shadow_realm_state = $ShadowRealmState
		if shadow_realm_state == null:
			print(name + " could not find ShadowRealm Node")
	
	# decides a random direction the entity will wander in
	_direction = _directions[randi() % _directions.size()]
	# states the default state to wander
	_state = States.WANDER
	# sets the detection zone to monitor in the shadow realm
	if _in_shadow_realm:
		detection_zone.monitoring = true
	else:
		detection_zone.monitoring = false

func _physics_process(delta: float) -> void:
	movement_handler.handle_gravity(self, delta)
	
	match _state:
		States.WANDER:
			wander(delta)
		States.CHASE:
			chase(delta, _target)
	
	move_and_slide()

# wanders back and forth until it hits a wall (goomba ai)
func wander(delta: float) -> void:
	# if creatures stops, changes direction
	if(velocity.x == 0):
		_direction *= -1
	movement_handler.handle_movement(self, _direction, delta)

# chases the player until it catches up
func chase(delta: float, target: CharacterBody2D) -> void:
	var target_direction = (target.global_position - self.position).normalized().x
	movement_handler.handle_movement(self, target_direction, delta)

func _on_phase_changed(entering_shadow_realm: bool):
	# check to see if state is different before phase change
	if _in_shadow_realm != entering_shadow_realm:
		do_phase_change(entering_shadow_realm)
	pass


func do_phase_change(entering_shadow_realm: bool):
	detection_zone = $DetectionZone
	_in_shadow_realm = entering_shadow_realm
	
	toggle_active_nodes()
	
	# turns on player monitoring when in shadow realm and turns it off when not
	if _in_shadow_realm:
		detection_zone.monitoring = true
		enter_shadow_realm()
	else:
		_state = States.WANDER
		detection_zone.monitoring = false
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


func _on_hit_box_body_entered(body: Node2D) -> void:
	if _in_shadow_realm:
		get_tree().reload_current_scene()


func _on_detection_zone_body_entered(body: CharacterBody2D) -> void:
	_target = body
	_state = States.CHASE


func _on_detection_zone_body_exited(body: CharacterBody2D) -> void:
	_state = States.WANDER
