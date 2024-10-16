extends Node

@export var gridW = 50
@export var gridH = 50
@export var tileSize = 2
var content = []

const red = preload("res://Materials/red.tres")
var blue = preload("res://Materials/blue.tres")
var green = preload("res://Materials/green.tres")

const TILE = preload("res://Assets/tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_generate_grid()

func _generate_grid():
	var tile_origin = TILE.instantiate()
	for x in range(gridW):
		var tile_coordinates := Vector2.ZERO
		tile_coordinates.x = x * tileSize
		tile_coordinates.y = 0
		for y in range(gridH):
			var tile = tile_origin.duplicate() 
			add_child(tile)
			tile.translate(Vector3(tile_coordinates.x, 0, tile_coordinates.y))
			tile_coordinates.y += tileSize
			content.push_back(tile)
	hide_grid()

func show_grid():
	for n in self.get_children():
		if n.get_child(1).is_occupied:
			n.get_node("tile/Plane").material_override = red
			n.visible = true
		elif n.get_child(1).is_selected:
			n.get_node("tile/Plane").material_override = green
			n.visible = true
		else:
			n.visible = false
		
		

func hide_grid():
	for n in self.get_children():
		n.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
