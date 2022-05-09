class_name GroundedState
extends State


var input = Vector2.ZERO

onready var character = $"../.."


# Called every frame by the finite state machine's process method
func _process_state(_delta: float):
	input.x = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_accept"):
		get_parent().change_state("JumpState")


# Called every frame by the finite state machine's physics process method
func _physics_process_state(_delta: float):
	character.velocity = input * character.speed
	character.velocity = character.move_and_slide(character.velocity)


func _on_DetectGround_area_entered(area):
	get_parent().current_state = self
