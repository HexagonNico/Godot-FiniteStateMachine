class_name FallState
extends State


var input = 0

onready var character = $"../.."


# Called every frame by the finite state machine's process method
func _process_state(_delta: float):
	input = Input.get_axis("ui_left", "ui_right")


# Called every frame by the finite state machine's physics process method
func _physics_process_state(delta: float):
	character.velocity.x = input * character.speed
	character.velocity.y -= character.gravity * delta
	character.velocity = character.move_and_slide(character.velocity)


func _on_DetectGround_area_exited(_area):
	var fsm = get_parent()
	if not fsm.current_state is JumpState:
		fsm.current_state = self
