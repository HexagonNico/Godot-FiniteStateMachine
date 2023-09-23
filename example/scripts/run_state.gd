class_name RunState
extends BaseState


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		change_state("Walk")
