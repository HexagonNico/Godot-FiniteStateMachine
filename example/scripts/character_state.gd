class_name CharacterState
extends StateMachineState


## Base class for all character states.
## Contains a reference to the character for easier access.


## Node path to the character.
@export_node_path("CharacterBody2D") var _character: NodePath = "../.."

# Reference to the character node.
@onready var character: CharacterBody2D = get_node(_character)


# Called when an animation is finished when this state is active.
func on_animation_finished(_anim_name: StringName) -> void:
	pass
