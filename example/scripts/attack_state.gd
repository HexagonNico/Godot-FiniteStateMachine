class_name AttackState
extends CharacterState


## Time before changing to the next state.
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var attack_time: float = 0.5
## State to change to when the attack time has passed.
@export var next_state: StateMachineState = null

## Acceleration used to decrease the character's horizontal velocity.
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s²") var deceleration: float = 2000.0

# Current attack time.
var _current_time: float = 0.0


# Called when the state machine enters this state.
func _enter_state() -> void:
	_current_time = 0.0


# Called every frame when this state is active.
func _process(delta: float) -> void:
	# Decrease the character's horizontal velocity
	character.velocity.x = move_toward(character.velocity.x, 0.0, delta * deceleration)
	# Increase the current time
	_current_time += delta
	# Change to the next state if enough time has passed
	if _current_time >= attack_time:
		_current_time = 0.0
		get_state_machine().current_state = next_state


# Called every physics tick when this state is active.
func _physics_process(delta: float) -> void:
	# The character should keep falling if they are in the air
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta
	# Move the character
	character.move_and_slide()
