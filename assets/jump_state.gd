class_name JumpState
extends State


export(int) var jump_strength = 400

var input = 0

onready var character = $"../.."


# Called when a state enters the finite state machine
func _enter_state():
	character.velocity = Vector2(0, -jump_strength)


# Called every frame by the finite state machine's process method
func _process_state(_delta: float):
	input = Input.get_axis("ui_left", "ui_right")
	if character.velocity.y < 0 and Input.is_action_just_released("ui_accept"):
		character.velocity.y = 0.0


# Called every frame by the finite state machine's physics process method
func _physics_process_state(delta: float):
	character.velocity.x = input * character.speed
	character.velocity.y -= character.gravity * delta
	character.velocity = character.move_and_slide(character.velocity)
