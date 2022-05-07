extends Node2D


onready var fsm = $FiniteStateMachine


func _ready():
	fsm.change_state("TestState")


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("---")
		if fsm.is_running():
			fsm.stop_running()
		else:
			fsm.change_state("TestState")
