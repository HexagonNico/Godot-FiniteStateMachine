tool
extends Node


var current_state: State = null


func _process(delta) -> void:
	if current_state != null:
		current_state._process_state(delta)


func _physics_process(delta) -> void:
	if current_state != null:
		current_state._physics_process_state(delta)


func change_state(state: String) -> void:
	if current_state != null:
		current_state._exit_state()
	current_state = get_node_or_null(state)
	if current_state != null:
		current_state._enter_state()


func stop_running():
	if current_state != null:
		current_state._exit_state()
	current_state = null


func is_running() -> bool:
	return current_state != null
