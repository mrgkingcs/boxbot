extends PanelContainer


var dragManager = null

var programBlocksNode = null

# Called when the node enters the scene tree for the first time.
func _ready():
	dragManager = get_node("../DragManager")
	programBlocksNode = get_node("TabContainer/Program/ProgramBlocks")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func getDropRect():
	return Rect2(programBlocksNode.rect_global_position, programBlocksNode.rect_size)

func handleDrag():
	if getDropRect().has_point(dragManager.draggingControl.global_position):
		print("handleDrag at ", dragManager.draggingControl.global_position)
	
func handleDrop():
	if getDropRect().has_point(dragManager.draggingControl.global_position):
		print("handleDrop at ", dragManager.draggingControl.global_position)

