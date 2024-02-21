@icon("../icons/state_machine_state.svg")
class_name StateMachineState
extends Node


## Class used as base for state machine states.
## Create a script that inherits from this class to create a state.


## Signal emitted when the state machine enters this state after calling the 'on_enter' function.
signal state_entered
## Signal emitted when the state machine exits this state after calling the 'on_exit' function.
signal state_exited


# Reference to the state machine node assigned when the state machine enters this state.
# Can be used to change the current state.
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


# Called when the state machine's AnimationPlayer emits the 'animation_started' signal.
func on_animation_started(_anim_name: StringName) -> void:
	pass


# Called when the state machine's AnimationPlayer emits the 'animation_finished' signal.
func on_animation_finished(_anim_name: StringName) -> void:
	pass


# Called when the state machine's AnimationPlayer emits the 'animation_changed' signal.
func on_animation_changed(_old_name: StringName, _new_name: StringName) -> void:
	pass


# Helper function that calls the 'change_state' function on the FiniteStateMachine node to change
# the current state to the one with the given name. It is recomended to only call this function
# from the current state, since it will fail if this state has not been the current state at least
# once. To change the current state from another script, use the 'change_state' function on the
# FiniteStateMachine node
func change_state(state_name: String) -> void:
	if is_instance_valid(state_machine):
		state_machine.change_state(state_name)
	else:
		push_error("State ", self, " has not been yet initialized")


# Checks if this state is the current one.
func is_current_state() -> bool:
	return is_instance_valid(state_machine) and state_machine.current_state == self
