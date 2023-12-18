class_name JumpState
extends CharacterState


@export var jump_velocity: float = 400.0

@onready var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


# Called when the state machine enters this state.
func on_enter() -> void:
	character.velocity.y = -jump_velocity


# Called every frame when this state is active.
func _process(delta: float) -> void:
	if character.is_on_floor():
		change_state("Walk")
		return
	if character.velocity.y > 0.0:
		character.play_animation("fall")
	else:
		character.play_animation("jump")
	character.velocity.y += gravity * delta


# Called every physics frame when this state is active.
func _physics_process(_delta: float) -> void:
	character.move_and_slide()
