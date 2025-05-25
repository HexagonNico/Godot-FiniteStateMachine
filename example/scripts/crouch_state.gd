class_name CrouchState
extends CharacterState


## State to change to when the player gets up.
@export var get_up_state: StateMachineState = null


# Called when there is an input event when this state is active.
func _unhandled_input(event: InputEvent) -> void:
	# Get up when the player releases the crouch button
	if event.is_action_released("example_down"):
		get_state_machine().current_state = get_up_state
