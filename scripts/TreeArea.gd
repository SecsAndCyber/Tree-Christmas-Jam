extends Area2D

var tile = Vector2.ZERO
var tile_map = null
var game_scene = null
var cell_source_id = 0
var atlas_coords = Vector2.ZERO
var layer = 0
var is_pine_tree = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_tree_area_1_body_entered(_body):
	if _body.name == "Bounce":
		atlas_coords.y += 1

func _on_tree_area_1_body_exited(_body):
	if _body.name == "Bounce":
		(tile_map as TileMap).set_cell(layer,tile,cell_source_id, atlas_coords)
		game_scene.tree_count = clampi(game_scene.tree_count - 1, 0, game_scene.tree_count)
		if is_pine_tree:
			game_scene.pine_count = clampi(game_scene.pine_count + 1, 0, 1)
		queue_free()
