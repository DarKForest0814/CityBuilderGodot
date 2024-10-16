extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Cash.text = "MONEY : " + str(GameManager.money)
	$Time.text = "Time : 12:00"
	
### helper functions ###

func adjust_game_state():
	if GameManager.CurrentState != GameManager.State.Building:
		GameManager.CurrentState = GameManager.State.Building
		return true
	else:
		BuildManager.Currentspawnable.queue_free()
		BuildManager.Currentspawnable = null
		GameManager.CurrentState = GameManager.State.Play
		return false

### logic checks ###

func _on_area_2d_area_entered(area: Area2D) -> void:
	BuildManager.is_valid_build = false


func _on_area_2d_area_exited(area: Area2D) -> void:
	BuildManager.is_valid_build = true

### UI buttons ###

func on_build_button_down() -> void:
	print("info: Store selected")
	if GameManager.CurrentState != GameManager.State.Building:
		GameManager.CurrentState = GameManager.State.Building
		BuildManager.SpawnStore()
	else:
		BuildManager.Currentspawnable.queue_free()
		BuildManager.Currentspawnable = null
		GameManager.CurrentState = GameManager.State.Play


func _on_build_button_button_down() -> void:
	print("info: opening building menu")
	$BuildPanel.visible = true
	$BuildButton.visible = false


func _on_close_build_menu_button_down() -> void:
	$BuildButton.visible = true
	if BuildManager.Currentspawnable != null:
		BuildManager.Currentspawnable.queue_free()
		BuildManager.Currentspawnable = null
	print("info: closing building menu")
	GameManager.CurrentState = GameManager.State.Play
	$BuildPanel.visible = false

### pause menu buttons ###

func _on_menu_button_pressed() -> void:
	$PauseMenu.visible = true
	GameManager.PrevState = GameManager.CurrentState
	GameManager.CurrentState = GameManager.State.Pause

func _on_continue_pressed() -> void:
	$PauseMenu.visible = false
	GameManager.CurrentState = GameManager.PrevState


func _on_tot_title_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()

### building buttons ###

func _on_props_pressed() -> void:
	$BuildPanel/buildings_container.visible = false
	$BuildPanel/props_container.visible = true
	$BuildPanel/infrastructure_container.visible = false


func _on_buildings_pressed() -> void:
	$BuildPanel/buildings_container.visible = true
	$BuildPanel/props_container.visible = false
	$BuildPanel/infrastructure_container.visible = false


func _on_infrastructure_pressed() -> void:
	$BuildPanel/buildings_container.visible = false
	$BuildPanel/props_container.visible = false
	$BuildPanel/infrastructure_container.visible = true

func _on_store_pressed() -> void:
	print("info: Store selected")
	if adjust_game_state():
		BuildManager.SpawnStore()


func _on_house_pressed() -> void:
	print("info: House selected")
	if adjust_game_state():
		BuildManager.SpawnHouse()

func _on_street_pressed() -> void:
	print("info: Street selected")
	if adjust_game_state():
		BuildManager.SpawnStreet()


func _on_lantern_pressed() -> void:
	print("info: Lantern selected")
	if adjust_game_state():
		BuildManager.SpawnLantern()


func _on_tree_pressed() -> void:
	print("info: Tree selected")
	if adjust_game_state():
		BuildManager.SpawnTree()


func _on_gas_station_pressed() -> void:
	print("info: Gas_Station selected")
	if adjust_game_state():
		BuildManager.SpawnGasStation()


func _on_school_pressed() -> void:
	print("info: School selected")
	if adjust_game_state():
		BuildManager.SpawnSchool()
