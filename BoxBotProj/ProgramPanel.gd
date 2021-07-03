extends PanelContainer


var dragManager = null
var programBlocksNode = null
var blankCommand = null
var blankIndex = -1

# Called when the node enters the scene tree for the first time.
func _ready():
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
		if global_pos.x >= minX and global_pos.x < maxX:
			break

	return index

func handleDrag():
	if getDropRect().has_point(dragManager.draggingControl.global_position):
		var newIndex = findCommandIndexForPos(dragManager.draggingControl.global_position)
		print(newIndex)
		if blankIndex == -1:
			programBlocksNode.add_child(blankCommand)
		programBlocksNode.move_child(blankCommand, newIndex)
		blankIndex = newIndex
	elif blankIndex != -1:
		blankCommand.get_parent().remove_child(blankCommand)
		blankIndex = -1
	
func handleDrop():
	if getDropRect().has_point(dragManager.draggingControl.global_position):
		#print("handleDrop at ", dragManager.draggingControl.global_position)
		if blankIndex != -1:
			blankCommand.get_parent().remove_child(blankCommand)
			var newCommand = dragManager.controlBeingDragged.duplicate()
			for currSignal in newCommand.get_signal_list():
				for connection in newCommand.get_signal_connection_list(currSignal.name):
					print(connection)
					newCommand.disconnect(currSignal.name, connection.target, connection.method)
					newCommand.connect(currSignal.name, self, connection.method, [newCommand])
			programBlocksNode.add_child(newCommand)
			programBlocksNode.move_child(newCommand, blankIndex)
			blankIndex = -1

func _on_command_mouse_entered(command):
#	if commandIndex != highlightedIndex:
#		highlightedIndex = commandIndex
#		highlightDirty = true
	print("ProgramPanel:_on_command_mouse_entered:", command.get_index())

func _on_command_mouse_exited(command):
#	if commandIndex == highlightedIndex:
#		highlightedIndex = -1
#		highlightDirty = true
	print("ProgramPanel:_on_command_mouse_exited", command.get_index())

func _on_command_gui_input(event, command):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT:
#			if event.pressed == true:
#				var command = get_node("GridContainer/CommandIconContainer").get_child(highlightedIndex)
#				dragManager.begin_drag(commandIndex, command)
		print("ProgramPanel:_on_command_gui_input", command.get_index())
