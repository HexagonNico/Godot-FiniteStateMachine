class_name State
extends Node


# Node representing a state for a finite state machine
# Add this as a child of a finite state machine node


# Virtual function to be implemented by a subclass
# Called when a state enters the finite state machine
func _enter_state() -> void:
	pass


# Virtual function to be implemented by a subclass
# Called every frame by the finite state machine's process method
func _process_state(_delta: float) -> void:
	pass


# Virtual function to be implemented by a subclass
# Called every frame by the finite state machine's physics process method
func _physics_process_state(_delta: float) -> void:
	pass


# Virtual function to be implemented by a subclass
# Called when a state exits the finte state machine
func _exit_state() -> void:
	pass
