class_name TestState
extends StateMachineState


@onready var test := get_node("../..")


func on_enter() -> void:
	print("Enter ", test)


func on_exit() -> void:
	print("Exit ", test)
