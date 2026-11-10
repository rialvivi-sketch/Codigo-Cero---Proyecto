extends Node2D

@export var enemy : PackedScene
@export var enemy_2 : PackedScene
@export var enemy_3: PackedScene

const SCORE_TO_UNLOCK = 2000
const SCORE_TO_UNLOCK_3 = 2500
const SCORE_TO_LEVEL2 = 5000

var level_completed = false



func _ready() -> void:
	GLOBAL.credits = 1
	GLOBAL.nivel_actual = "res://Escenas/nivel_2.tscn"

func _process(delta) -> void:
	parallax_bg(delta)
	$PathSpawn/PathFollow.set_progress($PathSpawn/PathFollow.get_progress() + 80 * delta)

	if GLOBAL.score >= SCORE_TO_LEVEL2 and not level_completed:
		level_completed = true
		Transicion.mostrar_nivel(3, "res://Escenas/nivel_3.tscn")

func parallax_bg(delta_time) -> void:
	get_node("Fondo/Back").scroll_base_offset -= Vector2(1, 0) * 8 * delta_time
	$Fondo/Edificios.scroll_base_offset -= Vector2(1, 0) * 16 * delta_time
	$Fondo/Escritorios.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time
	$Fondo/Ventanales.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time
	
func _on_timer_timeout():
	var enemy_scene = enemy

	if GLOBAL.score >= SCORE_TO_UNLOCK_3:
		var random_enemy = randi_range(0, 2)

		match random_enemy:
			0:
				enemy_scene = enemy
			1:
				enemy_scene = enemy_2
			2:
				enemy_scene = enemy_3

	elif GLOBAL.score >= SCORE_TO_UNLOCK:
		if randi_range(0, 1) == 1:
			enemy_scene = enemy_3

	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = $PathSpawn/PathFollow.global_position
	add_child(enemy_instance)
