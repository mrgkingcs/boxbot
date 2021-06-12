extends Spatial


# Declare member variables here. Examples:
var botMeshAnimationPlayer = null
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	botMeshAnimationPlayer = get_node(("boxbotMesh_anim/AnimationPlayer"))
	print(botMeshAnimationPlayer.get_animation_list())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if not botMeshAnimationPlayer.playback_active:
		if Input.is_key_pressed(KEY_UP):
			botMeshAnimationPlayer.play("Armature|Forward")
		elif Input.is_key_pressed(KEY_DOWN):
			botMeshAnimationPlayer.play("Armature|Backward")
		elif Input.is_key_pressed(KEY_LEFT):
			botMeshAnimationPlayer.play("Armature|Left")
		elif Input.is_key_pressed(KEY_RIGHT):
			botMeshAnimationPlayer.play("Armature|Right")
			
