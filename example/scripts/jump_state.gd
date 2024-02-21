class_name JumpState
extends CharacterState


@export var jump_velocity: float = 400.0

@onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


# Called when the state machine enters this state.
func on_enter() -> void:
	character.velocity.y = -jump_velocity


# Called every frame when this state is active.
func on_process(delta: float) -> void:
	character.velocity.y += gravity * delta
	if character.velocity.y > 0.0:
		state_machine.animation_player.play("fall")
		if character.is_on_floor():
			change_state("Walk")
	else:
		state_machine.animation_player.play("jump")


# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	character.move_and_slide()
