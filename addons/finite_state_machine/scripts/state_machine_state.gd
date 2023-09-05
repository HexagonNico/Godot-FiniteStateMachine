class_name StateMachineState
extends Node


## Base class for all state machine states.


# Reference to the state machine node.
# Assigned when the state machine enters this state for the first time.
var state_machine: FiniteStateMachine = null


# Called when the state machine enters this state.
func on_enter() -> void:
	pass


# Called every frame when this state is active.
func on_process(_delta: float) -> void:
	pass


# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	pass


# Called when there is an input event while this state is active.
func on_input(_event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func on_exit() -> void:
	pass


func change_state(state_name: String) -> void:
	if is_instance_valid(state_machine):
		state_machine.change_state(state_name)


# Checks if this state is the current one.
func is_current_state() -> bool:
	return is_instance_valid(state_machine) and state_machine.current_state == self
