class_name BaseState
extends CharacterState


@export var speed: float = 300.0


# Called every frame when this state is active.
func on_process(_delta: float) -> void:
	# Basic movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		character.velocity.x = direction * speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, speed)
	# Change to jump state
	if Input.is_action_just_pressed("ui_accept"):
		change_state("Jump")
	# Update animation
	if Input.is_action_just_pressed("ui_left"):
		character.play_animation("walk_left")
	if Input.is_action_just_pressed("ui_right"):
		character.play_animation("walk_right")


# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	character.move_and_slide()
