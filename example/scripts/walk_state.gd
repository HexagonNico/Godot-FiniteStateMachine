class_name WalkState
extends BaseState


func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		change_state("Run")
