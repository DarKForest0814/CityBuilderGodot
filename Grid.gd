extends Node

@export var gridW = 200
@export var gridH = 200
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
	for x in range(gridW):
		var tile_coordinates := Vector2.ZERO
		tile_coordinates.x = x * tileSize
		tile_coordinates.y = 0
		for y in range(gridH):
			var tile = TILE.instantiate()
			add_child(tile)
			tile.translate(Vector3(tile_coordinates.x, 0, tile_coordinates.y))
			tile_coordinates.y += tileSize
			content.append("")
	hide_grid()

func show_grid():
	var index = 0
	for n in self.get_children():
		if content[index] == "test":
			if n.get_node("tile/Plane").get_active_material(0) != green:
				n.get_node("tile/Plane").material_override = green
		elif content[index] != "":
			if n.get_node("tile/Plane").get_active_material(0) != red:
				n.get_node("tile/Plane").material_override = red
		elif content[index] == "":
			if n.get_node("tile/Plane").get_active_material(0) != blue:
				n.get_node("tile/Plane").material_override = blue
		n.visible = true
		index += 1
		

func hide_grid():
	for n in self.get_children():
		n.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
