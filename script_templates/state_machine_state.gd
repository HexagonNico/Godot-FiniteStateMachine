# meta-description: Base template for a StateMachineState script
# meta-default: true

extends _BASE_


# Called when the state machine enters this state.
func on_enter() -> void:
	pass


# Called every frame when this state is active.
func on_process(delta: float) -> void:
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func on_exit() -> void:
	pass
