extends Spatial


# Declare member variables here. Examples:
var botMeshAnimationPlayer = null
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	botMeshAnimationPlayer = get_node(("boxbotMesh_anim/AnimationPlayer"))
	#botMeshAnimationPlayer.play("Action")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if not botMeshAnimationPlayer.playback_active:
		if Input.is_key_pressed(KEY_SPACE):
			botMeshAnimationPlayer.play("Forward")
			
