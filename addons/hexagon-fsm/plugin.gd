tool
extends EditorPlugin


# Initialization of the plugin
func _enter_tree():
	add_custom_type("FiniteStateMachine", "Node", preload("fsm.gd"), null)


# Clean up of the plugin
func _exit_tree():
	remove_custom_type("FiniteStateMachine")
