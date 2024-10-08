extends Node

var types = ["STR","BUI","STO"]
@export var type = ""
@export var gridW = 0
@export var gridH = 0
@export var gridOffsetX = 0
@export var gridOffsetY = 0

var ActiveBuilding

func _init():
	pass

func getWidth():
	return gridW
	
func getHeight():
	return gridH
