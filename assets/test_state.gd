class_name TestState
extends State


var time = 0.0
var physics_time = 0.0

# Called when a state enters the finite state machine
func _enter_state():
	print("Enter test state")


# Called every frame by the finite state machine's process method
func _process_state(delta: float):
	time += delta


# Called every frame by the finite state machine's physics process method
func _physics_process_state(delta: float):
	physics_time += delta


# Called when a state exits the finte state machine
func _exit_state():
	print("Exit test state")
	print("Time: " + str(time))
	print("Physics time: " + str(physics_time))
