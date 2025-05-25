
# Finite State Machine plugin

A GDScript implementation of the finite state machine pattern.

Adds node types for finite state machines and states.

## Installing the plugin in your project

The procedure is the same as other Godot plugins.
See the [Godot docs](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) for a full explanation.

1. Click the **AssetLib** tab at the top of the editor and look for Finite State Machine.

2. Download the plugin and install the contents of the `addons` and the `script_templates` folders into your project's directory. You don't need the contents of the `example` folder.

3. Go to **Project -> Project Settings... -> Plugins** and enable the plugin by checking "Enable".

## Plugin contents

The plugin contains two [script classes](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#doc-gdscript-basics-class-name): `FiniteStateMachine` and `StateMachineState`.
Both can be added to your scenes as nodes through the "Create New Node" menu.

![Create node](/example/readme/create_node.png)

The **FiniteStateMachine** node can be added as a child of your character's node and will handle the state machine's logic.

The **StateMachineState** class is an abstract class.
You can extend this script to create your states.

## Creating a state machine

Open the "Create New Node" menu and search for "FiniteStateMachine". Add this node in your character's scene.

![State machine scene](/example/readme/state_machine_scene.png)

A state machine by itself does nothing, you need to create a script for a state.
From the "Create script" menu, create a script that inherits from `StateMachineState`.

![Create script](/example/readme/create_script.png)

The script template downloaded with the plugin will generate some function stubs.
You can now implement these functions to create a state.

The Engine's built-in virtual functions will only be called on the active state.

```
class_name MyState
extends StateMachineState


# Called when the state machine enters this state.
func _enter_state() -> void:
	pass


# Called every frame when this state is active.
func _process(delta: float) -> void:
	pass


# Called every physics tick when this state is active.
func _physics_process(_delta: float) -> void:
	pass


# Called when there is an input event when this state is active.
func _unhandled_input(event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func _exit_state() -> void:
	pass
```

Once a state is created, you can add it as a child of the FiniteStateMachine node.
Assign a state to the state machine from the inspector to set that as the initial state.

You can now change between states from your scripts by setting the `current_state` property.

![Player character scene](/example/readme/player_character_scene.png)

## Examples

The [example](/example) directory contains a simple implementation of a state machine.
See [grounded_state.gd](/example/scripts/grounded_state.gd) for an example implementation of a state.

Another example can be seen in the [2D platformer section of the Twenty Games Challenge](https://codeberg.org/HexagonNico/TwentyGamesChallenge/src/branch/main/game3)

## Credits

* Project icon: https://creazilla.com/media/icon/3211126/state-machine (Apache License 2.0)

* Example character: https://rvros.itch.io/animated-pixel-hero
