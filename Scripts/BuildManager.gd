extends Node3D

### loading objects ###
var shop: PackedScene = ResourceLoader.load("res://Assets/Store.tscn")
var house = ResourceLoader.load("res://Assets/House.tscn")
var street = ResourceLoader.load("res://Assets/Street.tscn")
var lantern = ResourceLoader.load("res://Assets/Lantern.tscn")
var tree = ResourceLoader.load("res://Assets/Tree.tscn")
var gas_station = ResourceLoader.load("res://Assets/Gas_station.tscn")
var school = ResourceLoader.load("res://Assets/School.tscn")

### loading materials
const red = preload("res://Materials/red.tres")
var blue = preload("res://Materials/blue.tres")
var green = preload("res://Materials/green.tres")

# current spawnable
var Currentspawnable : StaticBody3D
var CurrentspawnableCopy : StaticBody3D

# boolean for validation of building
var is_valid_build : bool = true
var is_not_occupied : bool = true

var selected = []
var prev_select = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.CurrentState == GameManager.State.Building and GameManager.CurrentState != GameManager.State.Pause:
		Grid.show_grid()
		# raycast from camera to ground
		var camera = get_viewport().get_camera_3d()
		var mouse_pos = get_viewport().get_mouse_position()
		var origin = camera.project_ray_origin(mouse_pos)
		var direction = camera.project_ray_normal(mouse_pos)
		if direction.y == 0:
			return

		var distance = -origin.y/direction.y
		var position = origin + direction * distance
		if Currentspawnable != null:
			Currentspawnable.get_child(2).visible = true
			for i in selected:
				i.is_selected = false
			selected = []
			for a in Currentspawnable.get_child(1).get_overlapping_areas():
				if a.is_in_group("tile"):
					a.is_selected = true
					selected.push_back(a)
			prev_select = selected
			is_not_occupied = true
			for i in selected:
				if i.is_occupied:
					is_not_occupied = false
			Currentspawnable.ActiveBuilding = true
			var gridX = round(abs(round(position.x)) / Grid.tileSize) #divided by tile size 
			var gridY = round(abs(round(position.z)) / Grid.tileSize) #divided by tile size
			if Input.is_action_just_released("LeftMouseDown"):
				if gridY < Grid.gridH + 1 and gridX < Grid.gridH + 1  and gridY > 0 and gridX > 0:
					Currentspawnable.global_position = Vector3(gridX * Grid.tileSize, position.y + 2, gridY * Grid.tileSize)
	else:
		Grid.hide_grid()
		
func place():
	Currentspawnable.get_child(2).visible = false
	if is_valid_build and is_not_occupied:
		var obj := CurrentspawnableCopy.duplicate()
		obj.ActiveBuilding = false
		get_tree().root.add_child(obj)
		obj.global_position = Currentspawnable.global_position
		obj.global_position.y -= 2
		for i in selected:
			i.is_occupied = true

### spawn functions ###

func SpawnHouse():
	SpawnObj(house)
	
func SpawnStore():
	SpawnObj(shop)

func SpawnStreet():
	SpawnObj(street)
	
func SpawnLantern():
	SpawnObj(lantern)

func SpawnTree():
	SpawnObj(tree)
	
func SpawnGasStation():
	SpawnObj(gas_station)
	
func SpawnSchool():
	SpawnObj(school)

func SpawnObj(obj):
	if Currentspawnable != null:
		Currentspawnable.queue_free()
	Currentspawnable = obj.instantiate()
	CurrentspawnableCopy = Currentspawnable.duplicate()
	# adding object to scene
	Currentspawnable.get_child(0).set_material_override(blue)
	get_tree().root.add_child(Currentspawnable)
