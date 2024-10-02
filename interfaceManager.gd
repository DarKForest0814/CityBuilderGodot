extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BuildPanel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Cash.text = "MONEY : " + str(GameManager.money)
	$Time.text = "Time : 12:00"

func on_build_button_down() -> void:
	print("info: Store selected")
	if GameManager.CurrentState != GameManager.State.Building:
		GameManager.CurrentState = GameManager.State.Building
		BuildManager.SpawnStore()
	else:
		BuildManager.Currentspawnable.queue_free()
		BuildManager.Currentspawnable = null
		GameManager.CurrentState = GameManager.State.Play

func _on_build_house_button_button_down() -> void:
	print("info: House selected")
	if GameManager.CurrentState != GameManager.State.Building:
		GameManager.CurrentState = GameManager.State.Building
		BuildManager.SpawnHouse()
	else:
		BuildManager.Currentspawnable.queue_free()
		BuildManager.Currentspawnable = null
		GameManager.CurrentState = GameManager.State.Play


func _on_area_2d_area_entered(area: Area2D) -> void:
	BuildManager.is_valid_build = false


func _on_area_2d_area_exited(area: Area2D) -> void:
	BuildManager.is_valid_build = true


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
