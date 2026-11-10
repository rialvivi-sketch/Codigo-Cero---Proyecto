
extends Node

var score: int = 0
var credits: int = 3
var axis: Vector2

var nave_seleccionada: String = "res://Imagenes/naves/CimaNave.png"
var nivel_actual: String = "res://Escenas/nivel1.tscn"

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()

func respawn_player() -> void:
	respawn_player_deferred.call_deferred()

func respawn_player_deferred() -> void:
	var player_scene = load("res://Escenas/Player.tscn")

	if player_scene == null:
		return

	var player = player_scene.instantiate()
	player.global_position = Vector2(0, 0)
	get_tree().current_scene.add_child(player)
