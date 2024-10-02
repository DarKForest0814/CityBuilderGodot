extends Node

# enum for storing possible states
enum State{
	Play,
	Building,
	Destroying
}

# current state of game
var CurrentState = State.Play

# current amount of money
var money := 100
var workers := 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
