extends Panel

var controlBeingDragged = null
var draggingControl = null
var isDragging = false

var dropTarget = null

# Called when the node enters the scene tree for the first time.
func _ready():
	draggingControl = get_node("DraggingCommand")
	dropTarget = get_node("../ProgramPanel")

func begin_drag(controlToDrag):
	draggingControl.global_position = controlToDrag.rect_global_position + controlToDrag.rect_size*0.5
	draggingControl.texture = controlToDrag.texture
	draggingControl.set_visible(true)
	controlBeingDragged = controlToDrag
	isDragging = true

func stop_drag():
	draggingControl.set_visible(false)
	controlBeingDragged = null

func _input(event):
	if isDragging:
		if event is InputEventMouseMotion:
			draggingControl.position += event.relative
			if dropTarget != null:
				dropTarget.handleDrag()
		elif event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed == false:
				if dropTarget != null:
					dropTarget.handleDrop()
				draggingControl.set_visible(false)
				isDragging = false


