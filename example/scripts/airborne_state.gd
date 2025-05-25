class_name AirborneState
extends MovementState


## State to change to when the player lands on the ground.
@export var grounded_state: StateMachineState = null


# Called every physics tick when this state is active.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	# Stop the fall and change to the ground state if the player landed
	if character.velocity.y >= 0.0 and character.is_on_floor():
		character.velocity.y = 0.0
		get_state_machine().current_state = grounded_state
	# Accelerate downwards if the player is in the airs
	else:
		character.velocity += character.get_gravity() * delta


# Called when there is an input event when this state is active.
func _unhandled_input(event: InputEvent) -> void:
	super._unhandled_input(event)
	# Stop the player's jump if they let go of the jump button
	if event.is_action_released("example_jump") and character.velocity.y < 0.0:
		character.velocity.y *= 0.25
