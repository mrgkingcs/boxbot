extends Panel


var draggingControl = null
var isDragging = false

#var prevMousePos = null

# Called when the node enters the scene tree for the first time.
func _ready():
	draggingControl = get_node("DraggingCommand")


func begin_drag(commandIndex, controlToDrag):
	draggingControl.global_position = controlToDrag.rect_global_position + controlToDrag.rect_size*0.5
	draggingControl.texture = controlToDrag.texture
	draggingControl.set_visible(true)
	isDragging = true

func stop_drag():
	draggingControl.set_visible(false)

func _input(event):
	if isDragging:
		if event is InputEventMouseMotion:
			draggingControl.position += event.relative
		elif event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed == false:
				draggingControl.set_visible(false)
				isDragging = false


