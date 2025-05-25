@icon("../icons/state_machine.svg")
class_name StateMachine
extends Node


## Node that represents an implementation of the finite state machine pattern.
##
## Node that represents an implementation of the finite state machine pattern.
## State nodes must be added as children of this node.
## [br][br]
## The state machine node is usually added as a child of a player or enemy node.
## The logic that controls the character should go in its state nodes.
## [br][br]
## See [StateMachineState].


## The state machine's current state.
## Setting this state will call [method StateMachineState._state_exited] on the previous state and [method StateMachineState._state_entered] on the new state.
## [br][br]
## Assigning a state from the inspector allows to select an initial state.
@export var current_state: StateMachineState = null: set = set_current_state, get = get_current_state

@export_group("Debug")
## [CanvasItem] node used to draw the name of the current state for debugging purposes.
## If assigned, a string with the name of the current state will be drawn on top of this node.
## [br][br]
## [b]Note:[/b] The name is only drawn in debug builds.
@export var debug_draw: CanvasItem = null: set = set_debug_draw, get = get_debug_draw
## Offset at which the name of the current state is drawn if [member debug_draw] is assigned.
@export var debug_draw_offset := Vector2.ZERO: set = set_debug_draw_offset, get = get_debug_draw_offset
## Color of the text drawn if [member debug_draw] is assigned.
@export var debug_draw_color := Color.WHITE: set = set_debug_draw_color, get = get_debug_draw_color


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Disable state nodes that are not the current state
	for child in get_children():
		if child is StateMachineState and child != current_state:
			child.process_mode = Node.PROCESS_MODE_DISABLED


# Called by the 'draw' signal emitted from the debug draw CanvasItem node.
func _on_debug_draw_draw() -> void:
	# Draw the name of the current state if a debug node was assigned
	if OS.is_debug_build() and is_instance_valid(debug_draw) and is_instance_valid(current_state):
		var text_size := ThemeDB.fallback_font.get_string_size(current_state.name)
		var position := debug_draw_offset + Vector2(text_size.x * -0.5, 0.0)
		debug_draw.draw_string(ThemeDB.fallback_font, position, current_state.name, HORIZONTAL_ALIGNMENT_LEFT, -1, 16, debug_draw_color)


# Called when the node exits the scene tree.
func _exit_tree() -> void:
	# Exit from the last state
	if is_instance_valid(current_state):
		current_state.process_mode = Node.PROCESS_MODE_DISABLED


# Setter function for 'current_state'.
func set_current_state(value: StateMachineState) -> void:
	# Ensure the given state is part of this state machine
	assert(not is_instance_valid(value) or value.get_parent() == self, "State node must be a child of the state machine node")
	# Ensure '_enter_state' is called after '_ready'
	if not is_node_ready():
		await ready
	# Disable the node to exit from the current state
	if is_instance_valid(current_state):
		current_state.process_mode = Node.PROCESS_MODE_DISABLED
	# Set the new state
	current_state = value
	# Enable the node to enter the new state
	if is_instance_valid(current_state):
		current_state.process_mode = Node.PROCESS_MODE_INHERIT
	# Draw the name of the new state if a debug node has been assigned
	if is_instance_valid(debug_draw):
		debug_draw.queue_redraw()


# Getter function for 'current_state'.
func get_current_state() -> StateMachineState:
	return current_state


# Setter function for 'debug_draw'.
func set_debug_draw(value: CanvasItem) -> void:
	# Disconnect the signal from the previous value
	if is_instance_valid(debug_draw) and debug_draw.draw.is_connected(_on_debug_draw_draw):
		debug_draw.draw.disconnect(_on_debug_draw_draw)
	# Set the new value and connect the signal
	debug_draw = value
	if is_instance_valid(debug_draw):
		debug_draw.draw.connect(_on_debug_draw_draw)


# Getter function for 'debug_draw'.
func get_debug_draw() -> CanvasItem:
	return debug_draw


# Setter function for 'debug_draw_offset'.
func set_debug_draw_offset(value: Vector2) -> void:
	debug_draw_offset = value
	# Redraw the text because the offset changed
	if is_instance_valid(debug_draw):
		debug_draw.queue_redraw()


# Getter function for 'debug_draw_offset'.
func get_debug_draw_offset() -> Vector2:
	return debug_draw_offset


# Setter function for 'debug_draw_color'.
func set_debug_draw_color(value: Color) -> void:
	debug_draw_color = value
	# Redraw the text because the color changed
	if is_instance_valid(debug_draw):
		debug_draw.queue_redraw()


# Getter function for 'debug_draw_color'.
func get_debug_draw_color() -> Color:
	return debug_draw_color
