extends Node
class_name GridTile

# current object
var object
@onready
var t = self.get_parent()

# state of tile
var is_occupied = false
var is_selected = false
