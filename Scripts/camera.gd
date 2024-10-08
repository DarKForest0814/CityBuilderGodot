extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var treshold = 10   # threshold for beginning movement
	var stepValue = 1   # movement steps
	var viewportSize = get_viewport().size    # getting viewport size to calculate treshold for camera movement
	var mousePos = get_viewport().get_mouse_position()
	
	if GameManager.CurrentState != GameManager.State.Pause:
		# movement along x axis
		if mousePos.x < treshold:
			position.x -= stepValue
		elif mousePos.x > viewportSize.x - treshold:
			position.x += stepValue
	
		# movement along y axis
		if mousePos.y < treshold:
			position.z -= stepValue
		elif mousePos.y > viewportSize.y - treshold:
			position.z += stepValue
