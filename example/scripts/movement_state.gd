class_name MovementState
extends CharacterState


## The character's movement speed.
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var speed: float = 200.0
## The character's movement acceleration.
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s²") var acceleration: float = 2000.0

## State to change to when the player attacks.
@export var attack_state: StateMachineState = null


# Called every frame when this state is active.
func _process(delta: float) -> void:
	# Read input and update the horizontal velocity
	var input := Input.get_axis("example_left", "example_right")
	character.velocity.x = move_toward(character.velocity.x, speed * input, acceleration * delta)


# Called every physics tick when this state is active.
func _physics_process(_delta: float) -> void:
	# Move the character
	character.move_and_slide()


# Called when there is an input event when this state is active.
func _unhandled_input(event: InputEvent) -> void:
	# Change to the attack state if the player attacked
	if event.is_action_pressed("example_attack"):
		get_state_machine().current_state = attack_state
