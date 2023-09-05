extends CharacterBody2D


@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _state_machine: Node = $FiniteStateMachine


func play_animation(anim_name: String) -> void:
	_animation_player.play(anim_name)


func _on_animation_finished(anim_name: StringName) -> void:
	if _state_machine.current_state is CharacterState:
		_state_machine.current_state.on_animation_finished(anim_name)
