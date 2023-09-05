class_name RunState
extends BaseState


func on_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		change_state("Walk")
