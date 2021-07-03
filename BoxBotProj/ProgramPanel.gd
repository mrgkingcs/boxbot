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
		var childRect = Rect2(child.rect_global_position, child.rect_size)
		if childRect.has_point(global_pos):
			break
	return index

func handleDrag():
	if getDropRect().has_point(dragManager.draggingControl.global_position):
		if blankIndex == -1:
			programBlocksNode.add_child(blankCommand)
			blankIndex = 0
			#print("handleDrag at ", dragManager.draggingControl.global_position)
	elif blankIndex != -1:
		blankCommand.get_parent().remove_child(blankCommand)
		blankIndex = -1
	
func handleDrop():
	if getDropRect().has_point(dragManager.draggingControl.global_position):
		#print("handleDrop at ", dragManager.draggingControl.global_position)
		if blankIndex != -1:
			blankCommand.get_parent().remove_child(blankCommand)
			blankIndex = -1
			var newCommand = dragManager.controlBeingDragged.duplicate()
			programBlocksNode.add_child(newCommand)

