
# Hexagon FiniteStateMachine

![Icon](icon.png)

Adds node types for finite state machines and states

## Installing the addon to your project

The procedure is the same as other Godot plugins.

* Extract the zip archive you downloaded

* Copy the `addons` folder and the `script_templates` folder into your project's root directory

* Go to `Project -> Project Settings... -> Plugins` and enable the plugin by checking "Enable"

See the [Godot docs](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) for a full explanation.

## Using the finite state machine

Once the addon is installed, you will be able to add a FiniteStateMachine node to any of your scenes.

Press Ctrl+A or click the '+' button in the Scene tab and search "FiniteStateMachine" to add the node.

A finite state machine by itself does nothing, it needs states to run. To create a state, right-click in the FileSystem dock and select `New Script...`. From the Create Script window, choose the "FSM State" template, this will automatically generate all the needed methods.

From the script screen, give a class name to your state. This will allow you to add your state to your finite state machine from the Create New Node window.

Once the state is created, you will be able to add the state as a child node of the FiniteStateMachine node by pressing Ctrl+a or by clicking the '+' button in the Scene tab and searching for your state's name.

You can now start the finite state machine by calling the following method on the FiniteStateMachine node:
```
	var finite_state_machine = $FiniteStateMachine
	finite_state_machine.change_state("YourStateNode")
```