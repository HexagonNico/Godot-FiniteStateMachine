class_name State
extends Node


# Node representing a state for a finite state machine
# Add this as a child of a finite state machine node


# Path to the base node the state machine is using
# Tipically your character's node
export(NodePath) var base_node_path = "../.."
# The base node the state machine is using
onready var base_node = get_node_or_null(base_node_path)


# Called when a state enters the finite state machine
func _enter_state():
	pass


# Called every frame by the finite state machine's process method
func _process_state(delta: float):
	pass


# Called every frame by the finite state machine's physics process method
func _physics_process_state(delta: float):
	pass


# Called when a state exits the finte state machine
func _exit_state():
	pass
