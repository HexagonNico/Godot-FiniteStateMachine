class_name ExampleCharacter
extends KinematicBody2D


export(int) var speed = 160
export(int) var gravity = -600

var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time
func _ready():
	var fsm = $FiniteStateMachine
	fsm.change_state("FallState")
