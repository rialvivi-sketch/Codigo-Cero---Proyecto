extends Node

var score : int = 0
var credits : int = 1
var axis : Vector2
var nave_seleccionada : String = "res://Escenas/Player.tscn"
var nivel_actual: String = "res://Escenas/nivel1.tscn"

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized() 
	
