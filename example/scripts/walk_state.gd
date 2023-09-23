class_name WalkState
extends BaseState


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		change_state("Run")
