class_name FiniteStateMachine
extends Node


## Implementation of the finite state machine pattern.


## The state machine's current state.
## Setting this state will call 'on_exit' on the previous state and 'on_enter' on the new state.
@export var current_state: StateMachineState:
	set(next_state):
		# Exit from the previous state
		if is_node_ready() and is_instance_valid(current_state):
			current_state.on_exit()
		current_state = next_state
		# Enter the new state
		if is_instance_valid(current_state):
			current_state.state_machine = self
			if is_node_ready():
				current_state.on_enter()


# TODO: Check if this can be replaced by '_enter_tree'.
func _ready() -> void:
	if is_instance_valid(current_state):
		current_state.on_enter()


# Called every frame.
func _process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.on_process(delta)


# Called every physics frame.
func _physics_process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.on_physics_process(delta)


# Called when there is an input event that hasn't been consumed by the gui.
func _unhandled_input(event: InputEvent) -> void:
	if is_instance_valid(current_state):
		current_state.on_input(event)


func _exit_tree() -> void:
	if is_instance_valid(current_state):
		current_state.on_exit()


# Changes state to the one at the given path relative to this node.
func change_state(node_path: NodePath) -> void:
	var next_state := get_node(node_path)
	if next_state is StateMachineState:
		current_state = next_state
	else:
		push_error("Node ", next_state, " at path ", node_path, " is not a StateMachineState")
