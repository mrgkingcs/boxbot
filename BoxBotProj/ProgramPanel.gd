extends PanelContainer


var dragManager = null
var programBlocksNode = null
var blankCommand = null
var blankIndex = -1

var commandHighlight = null
var highlightedIndex = -1
var highlightDirty = false

# Called when the node enters the scene tree for the first time.
func _ready():
	commandHighlight = get_node("../CommandHighlight")
	commandHighlight.set_visible(false)
	dragManager = get_node("../DragManager")
	programBlocksNode = get_node("TabContainer/Program/ProgramBlocks")
	blankCommand = get_node("../CommandBlank").duplicate()
	blankCommand.visible = true

func getDropRect():
	return Rect2(programBlocksNode.rect_global_position, programBlocksNode.rect_size)

func findCommandIndexForPos(global_pos):
	var index = -1
	for child in programBlocksNode.get_children():
		index += 1
		var minX = child.rect_global_position.x;
		var maxX = minX + child.rect_size.x;
		if global_pos.x < maxX:
			break

	return index

func handleDrag():
	if getDropRect().has_point(dragManager.draggingControl.global_position):
		var newIndex = findCommandIndexForPos(dragManager.draggingControl.global_position)
		if blankIndex == -1:
			programBlocksNode.add_child(blankCommand)
		programBlocksNode.move_child(blankCommand, newIndex)
		blankIndex = newIndex
	elif blankIndex != -1:
		blankCommand.get_parent().remove_child(blankCommand)
		blankIndex = -1
	
func handleDrop():
	if getDropRect().has_point(dragManager.draggingControl.global_position):
		if blankIndex != -1:
			blankCommand.get_parent().remove_child(blankCommand)
			var newCommand = dragManager.controlBeingDragged.duplicate()
			for currSignal in newCommand.get_signal_list():
				for connection in newCommand.get_signal_connection_list(currSignal.name):
					newCommand.disconnect(currSignal.name, connection.target, connection.method)

			newCommand.connect("mouse_entered", self, "_on_command_mouse_entered", [newCommand])
			newCommand.connect("mouse_exited", self, "_on_command_mouse_exited", [newCommand])
			newCommand.connect("gui_input", self, "_on_command_gui_input", [newCommand])

			print(newCommand.get_meta('COMMAND'))

			programBlocksNode.add_child(newCommand)
			programBlocksNode.move_child(newCommand, blankIndex)
			blankIndex = -1

func _on_command_mouse_entered(command):
	var commandIndex = command.get_index()
	if commandIndex != highlightedIndex:
		highlightedIndex = commandIndex
		highlightDirty = true

func _on_command_mouse_exited(command):
	var commandIndex = command.get_index()
	if commandIndex == highlightedIndex:
		highlightedIndex = -1
		highlightDirty = true

func _on_command_gui_input(event, command):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				dragManager.begin_drag(command)
				command.get_parent().remove_child(command)
				highlightedIndex = -1
				highlightDirty = true

func _process(delta):
	if highlightDirty:
		update_highlight()
		highlightDirty = false

func update_highlight():
	if highlightedIndex != -1:
		commandHighlight.set_visible(true)
		var command = programBlocksNode.get_child(highlightedIndex)
		if command != null:
			commandHighlight.rect_size = command.rect_size
			commandHighlight.rect_global_position = command.rect_global_position
		else:
			commandHighlight.set_visible(false)
	else:
		commandHighlight.set_visible(false)

