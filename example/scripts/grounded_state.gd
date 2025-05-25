class_name GroundedState
extends MovementState


## Vertical speed to apply when the player jumps.
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var jump_speed: float = 600.0
## State to change to when the player jumps or falls off a ledge.
@export var airborne_state: StateMachineState = null

## State to change to when the player crouches.
@export var crouch_state: StateMachineState = null


# Called every physics tick when this state is active.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	# Change to the airborne state if the player is no longer on the ground
	if not character.is_on_floor():
		get_state_machine().current_state = airborne_state


# Called when there is an input event when this state is active.
func _unhandled_input(event: InputEvent) -> void:
	super._unhandled_input(event)
	# Detect jump inputs if the level is not over
	if event.is_action_pressed("example_jump"):
		# Apply a vertical speed
		character.velocity.y = -jump_speed
		# Change to the airborne state
		get_state_machine().current_state = airborne_state
	# Change state when the player crouches
	elif event.is_action_pressed("example_down") and character.velocity.is_zero_approx():
		get_state_machine().current_state = crouch_state
