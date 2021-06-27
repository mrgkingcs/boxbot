extends PanelContainer


var commandHighlight = null
var highlightedIndex = -1
var highlightDirty = false

var dragManager = null


# Called when the node enters the scene tree for the first time.
func _ready():
	commandHighlight = get_node("../CommandHighlight")
	commandHighlight.set_visible(false)

	dragManager = get_node("../DragManager")
	
func _process(delta):
	if highlightDirty:
		update_highlight()

func update_highlight():
	if highlightedIndex != -1:
		commandHighlight.set_visible(true)
		var command = get_node("GridContainer/CommandIconContainer").get_child(highlightedIndex)
		commandHighlight.rect_size = command.rect_size
		commandHighlight.rect_global_position = command.rect_global_position
		queue_sort()
	else:
		commandHighlight.set_visible(false)


func _on_command_mouse_entered(commandIndex):
	if commandIndex != highlightedIndex:
		highlightedIndex = commandIndex
		highlightDirty = true


func _on_command_mouse_exited(commandIndex):
	if commandIndex == highlightedIndex:
		highlightedIndex = -1
		highlightDirty = true


func _on_command_gui_input(event, commandIndex):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				var command = get_node("GridContainer/CommandIconContainer").get_child(highlightedIndex)
				dragManager.begin_drag(commandIndex, command)
			else:
				print("Pressed:", event.pressed)
		else:
			print("Mouse button: ",event.button_index)


