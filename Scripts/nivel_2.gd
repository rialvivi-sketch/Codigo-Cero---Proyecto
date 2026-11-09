extends Node2D

@export var enemy : PackedScene
@export var enemy2 : PackedScene

const SCORE_TO_UNLOCK = 500

const PLAYER_SCENE = preload("res://Escenas/Player.tscn")


func _ready() -> void:
	GLOBAL.score = 0
	GLOBAL.credits = 1

func _process(delta) -> void:
	parallax_bg(delta)
	$PathSpawn/PathFollow.set_progress($PathSpawn/PathFollow.get_progress() + 80 * delta)

func parallax_bg(delta_time) -> void:
	get_node("Fondo/Back").scroll_base_offset -= Vector2(1, 0) * 8 * delta_time
	$Fondo/Edificios.scroll_base_offset -= Vector2(1, 0) * 16 * delta_time
	$Fondo/Escritorios.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time
	$Fondo/Ventanales.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time
	
func _on_timer_timeout():
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = $PathSpawn/PathFollow.global_position
	add_child(enemy_instance)
	
