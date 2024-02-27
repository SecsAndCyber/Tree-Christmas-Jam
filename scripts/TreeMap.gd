extends TileMap

@onready var game_scene = get_node("..")
@export var skip_triggers = false
var tree_area = preload("res://Actors/tree_area_1.tscn")

var TREE_LAYER = 0
var GROUND_LAYER = 1

var PINE_ATLAS_X = 2

var TREE_ATLAS_Y = 0
var WATER_ATLAS_Y = 6
var OBSTACLES_ATLAS_Y = 9
# Called when the node enters the scene tree for the first time.
func _ready():
	if skip_triggers:
		return
	var tree_tile_1 = get_used_cells_by_id(TREE_LAYER)
	
	for tile in tree_tile_1:
		var atlas_coords = get_cell_atlas_coords (TREE_LAYER, tile)
		if atlas_coords.y == TREE_ATLAS_Y:
			var tree_area_instance = tree_area.instantiate()
			tree_area_instance.position = map_to_local(tile)
			tree_area_instance.connect("body_entered", tree_area_instance._on_tree_area_1_body_entered)
			tree_area_instance.connect("body_exited", tree_area_instance._on_tree_area_1_body_exited)
			tree_area_instance.name = "Tree" + str(tile)
			tree_area_instance.tile = tile
			tree_area_instance.tile_map = self
			tree_area_instance.game_scene = game_scene
			tree_area_instance.layer = TREE_LAYER
			tree_area_instance.cell_source_id = get_cell_source_id(TREE_LAYER, tile)
			tree_area_instance.atlas_coords = atlas_coords
			tree_area_instance.is_pine_tree = tree_area_instance.atlas_coords.x == PINE_ATLAS_X
			
			game_scene.tree_count += 1
			add_child(tree_area_instance)
		elif atlas_coords.y >= OBSTACLES_ATLAS_Y:
			var tree_area_instance = tree_area.instantiate()
			tree_area_instance.position = map_to_local(tile)
			tree_area_instance.name = "Obstacle" + str(tile)
			tree_area_instance.colliderName = "Obstacle" + str(tile)
			tree_area_instance.tile_map = self
			tree_area_instance.game_scene = game_scene
			tree_area_instance.layer = TREE_LAYER
			tree_area_instance.cell_source_id = get_cell_source_id(TREE_LAYER, tile)
			tree_area_instance.atlas_coords = atlas_coords
			tree_area_instance.is_pine_tree = false
			add_child(tree_area_instance)
			#Add bouncer
		elif atlas_coords.y >= WATER_ATLAS_Y:
			pass
			#Add water code

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

