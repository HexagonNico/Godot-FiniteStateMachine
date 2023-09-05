
# Finite State Machine plugin

A GDScript implementation of the finite state machine pattern.

Adds node types for finite state machines and states.

## Installing the plugin in your project

The procedure is the same as other Godot plugins.

1. Go to the [Releases section](https://github.com/HexagonNico/GodotPlugin-FiniteStateMachine/releases) and download the latest version.

2. Extract the zip archive and copy the `addons` and the `script_templates` folders into your project's directory.
You don't need the contents of the `example` folder.

3. Go to `Project -> Project Settings... -> Plugins` and enable the plugin by checking "Enable"

See the [Godot docs](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) for a full explanation.

## Using the finite state machine

Once the addon is installed, you will be able to add a FiniteStateMachine node to any of your scenes.

Press Ctrl+A or click the '+' button in the Scene tab and search "FiniteStateMachine" to add the node.

A finite state machine by itself does nothing, it needs states to run. To create a state, right-click in the FileSystem dock, select `New Script...` and create a script that inherits from `StateMachineState`.

Remember to give a class name to your script. This will allow you to add your state to your finite state machine from the Create New Node window.

Once the state is created, you will be able to add the state as a child node of the FiniteStateMachine node by pressing Ctrl+a or by clicking the '+' button in the Scene tab and searching for your state's name.

You can now set the state machine's initial state from the inspector.
