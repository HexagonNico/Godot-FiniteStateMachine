@icon("../icons/finite_state_machine.svg")
class_name FiniteStateMachine
extends Node


## Node that represents an implementation of the finite state machine pattern.
## Nodes that represent states need to be added as children of this node.


## Signal emitted every time the current state is changed. 'new_state' is the new state node.
## This signal won't be emitted for the state machine's initial state or when the node is not in
## the scene tree to prevent the signal from being emitted more than once for the same change.
signal state_changed(new_state: StateMachineState)


## The state machine's current state.
## Setting this state will call 'on_exit' on the previous state and 'on_enter' on the new state.
## Assigning a state from the inspector allows to select an initial state.
## Can be set to 'null' to clear the current state and stop the state machine.
@export var current_state: StateMachineState = null: set = set_current_state

## Optional reference to an AnimationPlayer node.
## If assigned, the state machine will call the 'on_animation_finished', 'on_animation_started',
## and the 'on_animation_changed' functions on the current state when the respective signals are
## emitted from the AnimationPlayer node.
@export var animation_player: AnimationPlayer = null: set = set_animation_player

# Private variable holding a dictionary that works as a cache for states used in 'change_state'.
var _cache: Dictionary = {}

# Remembers what the previous state was for the 'previous_state' function.
var _previous_state: StateMachineState = null


# Called when the node enters the scene tree. This function is called every time the node is
# removed and readded to the scene and ensures 'on_enter' is always called on the current state
# when the state machine node enters the scene tree. Note that 'on_enter' is not called from
# '_enter_tree' if the state machine node's '_ready' function has not been called yet to ensure
# that the state node's '_ready' function is called before 'on_enter'.
func _enter_tree() -> void:
	if is_node_ready() and is_instance_valid(current_state):
		current_state.on_enter()
		current_state.state_entered.emit()


# Called when the node enters the scene tree for the first time. This function is only called once
# during the node's lifetime and ensures that the 'on_enter' function on the initial state is
# called after its '_ready' function, since the setter function of exported variables is called
# before '_ready'.
func _ready() -> void:
	if is_instance_valid(current_state):
		current_state.on_enter()
		current_state.state_entered.emit()


# Called every frame.
# Calls the 'on_process' function on the current state.
func _process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.on_process(delta)


# Called every physics frame.
# Calls the 'on_physics_process' function on the current state.
func _physics_process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.on_physics_process(delta)


# Called when there is an input event that hasn't been consumed by the gui.
# Calls the 'on_input' function on the current state.
func _unhandled_input(event: InputEvent) -> void:
	if is_instance_valid(current_state):
		current_state.on_input(event)


# Called when the node exits the scene tree.
# Calls the 'on_exit' function on the current state.
func _exit_tree() -> void:
	if is_instance_valid(current_state):
		current_state.on_exit()
		current_state.state_exited.emit()


# Changes state to the one at the given path relative to the state machine node. This function can
# be used instead of setting 'current_state' directly to change to a state with the given name.
# If the node at the given path is not a StateMachineState node, the current state won't be changed
# and an error will be logged.
func change_state(node_path: NodePath) -> void:
	# Use the cached value if that state has already been accessed
	if is_instance_valid(_cache.get(node_path)):
		current_state = _cache[node_path]
	# Get the node if the requested state has not been accessed yet or if it was deleted
	else:
		# Get the node or log an error if the path does not exist
		var next_state := get_node(node_path) as StateMachineState
		# Change to the new state and cache the value
		if is_instance_valid(next_state):
			_cache[node_path] = next_state
			current_state = next_state
		# Log an error if the result is null or it is not a StateMachineState node.
		else:
			push_error("Node ", next_state, " at path ", node_path, " is not a valid StateMachineState")


# Changes the current state to the previous one or logs an error if the previous state is null or
# if the node has been freed. Only one previous state is kept in memory, therefore 'previous_state'
# may only be called once per state.
func previous_state() -> void:
	# Change to the previous state
	if is_instance_valid(_previous_state):
		current_state = _previous_state
		_previous_state = null
	# Log an error if the previous state is null or has been freed.
	else:
		push_error("Previous state ", _previous_state, " is not valid")


# Setter function for 'current_state'.
func set_current_state(next_state: StateMachineState) -> void:
	# Exit from the previous state
	if is_inside_tree() and is_instance_valid(current_state):
		current_state.on_exit()
		current_state.state_exited.emit()
	_previous_state = current_state
	current_state = next_state
	# Enter the new state
	if is_instance_valid(current_state):
		current_state.state_machine = self
		if is_inside_tree():
			state_changed.emit(current_state)
			current_state.on_enter()
			current_state.state_entered.emit()


# Setter function for 'animation_player'.
func set_animation_player(value: AnimationPlayer) -> void:
	# Disconnect signals from the previous value if there was any
	if is_instance_valid(animation_player):
		animation_player.animation_started.disconnect(_on_animation_started)
		animation_player.animation_finished.disconnect(_on_animation_finished)
		animation_player.animation_changed.disconnect(_on_animation_changed)
	# Assign the new value
	animation_player = value
	# Connect signals to the animation player
	if is_instance_valid(animation_player):
		animation_player.animation_started.connect(_on_animation_started)
		animation_player.animation_finished.connect(_on_animation_finished)
		animation_player.animation_changed.connect(_on_animation_changed)


# Called by the 'animation_started' signal emitted from the AnimationPlayer node.
# An AnimationPlayer needs to be assigned for this to be called.
func _on_animation_started(anim_name: StringName) -> void:
	if is_instance_valid(current_state):
		current_state.on_animation_started(anim_name)


# Called by the 'animation_finished' signal emitted from the AnimationPlayer node.
# An AnimationPlayer needs to be assigned for this function to be called.
func _on_animation_finished(anim_name: StringName) -> void:
	if is_instance_valid(current_state):
		current_state.on_animation_finished(anim_name)


# Called by the 'animation_changed' signal emitted from the AnimationPlayer node.
# An AnimationPlayer needs to be assigned for this function to be called.
func _on_animation_changed(old_name: StringName, new_name: StringName) -> void:
	if is_instance_valid(current_state):
		current_state.on_animation_changed(old_name, new_name)
