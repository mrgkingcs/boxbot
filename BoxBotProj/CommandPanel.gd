extends PanelContainer


var commandHighlight = null
var highlightedIndex = -1
var highlightDirty = false
var commandIconContainer = null

var dragManager = null

var commandIconTexture = "res://Images/ProgButtons.png"
var commandList = [
	['Forward', 0, 0],
	['Backward', 64, 0],
	['Left', 0, 64],
	['Right', 64, 64],
	['Pick Up', 0, 128],
	['Put Down', 64, 128],
]
# Called when the node enters the scene tree for the first time.
func _ready():
	commandHighlight = get_node("../CommandHighlight")
	commandHighlight.set_visible(false)

	commandIconContainer = get_node("GridContainer/CommandIconContainer")

	dragManager = get_node("../DragManager")
	
	var iconResource = load(commandIconTexture) as Texture
	for command in commandList:
		var control = TextureRect.new()
		var texture = AtlasTexture.new()
		texture.atlas = iconResource
		texture.region = Rect2(command[1], command[2], 64, 64)
		control.texture = texture
		control.name = command[0]
		control.set_h_size_flags(SIZE_SHRINK_CENTER)
		control.set_v_size_flags(SIZE_SHRINK_CENTER)
		control.set_meta(command[0], command[0])
		
		control.connect("mouse_entered", self, "_on_command_mouse_entered", [control])
		control.connect("mouse_exited", self, "_on_command_mouse_exited", [control])
		control.connect("gui_input", self, "_on_command_gui_input", [control])
		
		
		commandIconContainer.add_child(control)
	
func _process(delta):
	if highlightDirty:
		update_highlight()
		highlightDirty = false

func update_highlight():
	if highlightedIndex != -1:
		commandHighlight.set_visible(true)
		var command = commandIconContainer.get_child(highlightedIndex)
		commandHighlight.rect_size = command.rect_size
		commandHighlight.rect_global_position = command.rect_global_position
	else:
		commandHighlight.set_visible(false)


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
	var commandIndex = command.get_index()
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed == true:
				#var command = commandIconContainer.get_child(highlightedIndex)
				dragManager.begin_drag(command)


