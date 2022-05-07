tool
extends Node


# Finite state machine node
# Add this node as a child of your player or character's scene


# State machine's current state
# Setting this value will call '_exit_state' on the previous state and '_enter_state' on the new one
var current_state: State = null setget set_state


# Called every frame
# Calls '_process_state' on the current state
func _process(delta) -> void:
	if current_state != null:
		current_state._process_state(delta)


# Called every physics frame
# Calls '_physics_process_state' on the current state
func _physics_process(delta) -> void:
	if current_state != null:
		current_state._physics_process_state(delta)


# Changes the current state to a new one
# 'state' is the NodePath to the new state
func change_state(state: String) -> void:
	self.current_state = get_node_or_null(state)


# Setter function for 'current_state'
func set_state(state: State) -> void:
	if current_state != null:
		current_state._exit_state()
	current_state = state
	if current_state != null:
		current_state._enter_state()


# Stops the finite state machine by setting the current state to null
func stop_running():
	self.current_state = null


# Checks if the finite state machine is running by checking if the current state is null
func is_running() -> bool:
	return current_state != null
