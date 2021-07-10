extends Spatial


var gridTileScenePath = "res://Models/FloorTile.glb"
var wallXScenePath = "res://Models/Wall_X.glb"
var wallZScenePath = "res://Models/Wall_Z.glb"

# Called when the node enters the scene tree for the first time.
func _ready():
	var gridTileScene = load(gridTileScenePath) as PackedScene
	for x in range(-1, 2):
		for z in range(-1, 2):
			var tile = gridTileScene.instance()
			tile.translation = Vector3(x, 0, z)
			add_child(tile)

	var wallXScene = load(wallXScenePath) as PackedScene
	for z in range(-1, 2):
		var wall = wallXScene.instance()
		wall.translation = Vector3(-2, 0, z)
		add_child(wall)

	var wallZScene = load(wallZScenePath) as PackedScene
	for x in range(-1, 2):
		var wall = wallZScene.instance()
		wall.translation = Vector3(x, 0, -2)
		add_child(wall)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
