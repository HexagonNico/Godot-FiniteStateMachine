tool
extends Node


# Controls wether this state machine is running or not
# The current state can be paused and resumed by setting this value
# Setting the current state to null will also stop the state machine
export(bool) var paused = false
# State machine's current state
# Setting this value will call '_exit_state' on the previous state and '_enter_state' on the new one
# Set this to null to stop the state machine until a new state is set
var current_state: State = null setget set_state


# Called every frame
# Calls '_process_state' on the current state
func _process(delta) -> void:
	if is_running():
		current_state._process_state(delta)


# Called every physics frame
# Calls '_physics_process_state' on the current state
func _physics_process(delta) -> void:
	if is_running():
		current_state._physics_process_state(delta)


# Changes the current state to a new one
# 'state' is the NodePath to the new state
# Set this to null to stop the state machine
func change_state(state: NodePath) -> void:
	self.current_state = get_node_or_null(state) if state != null else null


# Setter function for 'current_state'
# 'state' is the new state node
# Set this to null to stop the state machine
func set_state(state: State) -> void:
	if current_state != null:
		current_state._exit_state()
	current_state = state
	if current_state != null:
		current_state._enter_state()


# Stops the finite state machine by setting the current state to null
# Once this is called, the previous state cannot be resume
# If you wish to resume the current state, use 'paused' instead
func stop_running() -> void:
	self.current_state = null


# Checks if the finite state machine is running
# Checks if the current state is not null and if the state machine is not paused
func is_running() -> bool:
	return current_state != null and not paused
