extends Node2D

@export var enemy : PackedScene
const SCORE_TO_LEVEL2 = 1500

var level_completed = false

const PLAYER_SCENE = preload("res://Escenas/Player.tscn")


func _ready() -> void:
	GLOBAL.score = 0
	GLOBAL.credits = 1

func _process(delta) -> void:
	parallax_bg(delta)
	$PathSpawn/PathFollow.set_progress($PathSpawn/PathFollow.get_progress() + 80 * delta)

	if GLOBAL.score >= SCORE_TO_LEVEL2 and not level_completed:
		level_completed = true
		get_tree().change_scene_to_file("res://Escenas/felicidades.tscn")

func parallax_bg(delta_time) -> void:
	get_node("Fondo/Back").scroll_base_offset -= Vector2(1, 0) * 8 * delta_time
	$Fondo/Edificios.scroll_base_offset -= Vector2(1, 0) * 16 * delta_time
	$Fondo/Escritorios.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time
	$Fondo/Ventanales.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time
	
func _on_timer_timeout():
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = $PathSpawn/PathFollow.global_position
	add_child(enemy_instance)
	
