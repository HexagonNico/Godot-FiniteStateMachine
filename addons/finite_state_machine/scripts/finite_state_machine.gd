class_name FiniteStateMachine, "res://addons/finite_state_machine/icons/finite_state_machine.svg"
extends Node


## Node that represents an implementation of the finite state machine pattern.
## Nodes that represent states need to be added as children of this node.


## Signal emitted every time the current state is changed. 'new_state' is the new state node.
## This signal won't be emitted for the state machine's initial state or when the node is not in
## the scene tree to prevent the signal from being emitted more than once for the same change.
signal state_changed(new_state)


## The state machine's initial state that can be set from the inspector.
export var _initial_state: NodePath

# The state machine's current state.
# Setting this state will call 'on_exit' on the previous state and 'on_enter' on the new state.
# Can be set to 'null' to clear the current state and stop the state machine.
var current_state: StateMachineState = null setget set_current_state

# Private variable holding a dictionary used as a cache for the 'change_state' function.
var _cache: Dictionary = {}
# Private variable needed to keep track of whether the '_ready' function has been called or not.
var _is_ready: bool = false


# Called when the node enters the scene tree. This function is called every time the node is
# removed and readded to the scene and ensures 'on_enter' is always called on the current state
# when the state machine node enters the scene tree. Note that 'on_enter' is not called from
# '_enter_tree' if the state machine node's '_ready' function has not been called yet to ensure
# that the state node's '_ready' function is called before 'on_enter'.
func _enter_tree() -> void:
	if _is_ready and is_instance_valid(current_state):
		current_state.on_enter()


# Called when the node enters the scene tree for the first time. This function is only called once
# during the node's lifetime and ensures that the 'on_enter' function on the initial state is
# called after its '_ready' function.
func _ready() -> void:
	_is_ready = true
	# The 'onready' keyword cannot be used because the setter function would not be called
	self.current_state = get_node(_initial_state)
	if is_instance_valid(current_state):
		current_state.on_enter()


# Called every frame. Calls the 'on_process' function on the current state.
func _process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.on_process(delta)


# Called every physics frame. Calls the 'on_physics_process' function on the current state.
func _physics_process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.on_physics_process(delta)


# Called when there is an input event that hasn't been consumed by the gui.
# Calls the 'on_input' function on the current state.
func _unhandled_input(event: InputEvent) -> void:
	if is_instance_valid(current_state):
		current_state.on_input(event)


# Called when the node exits the scene tree. Calls the 'on_exit' function on the current state.
func _exit_tree() -> void:
	if is_instance_valid(current_state):
		current_state.on_exit()


# Changes state to the one at the given path relative to the state machine node. This function can
# be used instead of setting 'current_state' directly to change to a state with the given name.
# If the node at the given path is not a StateMachineState node, the current state won't be changed
# and an error will be logged.
func change_state(node_path: NodePath) -> void:
	# Use the cached value if that state has already been accessed
	if is_instance_valid(_cache.get(node_path)):
		self.current_state = _cache[node_path]
	# Get the node if the requested state has not been accessed yet or if it was deleted
	else:
		# Get the node or log an error if the path does not exist
		var next_state := get_node(node_path) as StateMachineState
		# Change to the new state and cache the value
		if is_instance_valid(next_state):
			_cache[node_path] = next_state
			self.current_state = next_state
		# Log an error if the result is null or it is not a StateMachineState node.
		else:
			push_error(str("Node ", next_state, " at path ", node_path, " is not a valid StateMachineState"))


# Setter function for 'current_state'.
func set_current_state(next_state: StateMachineState) -> void:
	# Exit from the previous state
	if is_inside_tree() and is_instance_valid(current_state):
		current_state.on_exit()
	current_state = next_state
	# Enter the new state
	if is_instance_valid(current_state):
		current_state.state_machine = self
		if is_inside_tree():
			emit_signal("state_changed", current_state)
			current_state.on_enter()
