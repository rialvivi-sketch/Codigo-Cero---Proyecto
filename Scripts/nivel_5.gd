
extends Node2D

@export var enemy : PackedScene
@export var enemy_2 : PackedScene
@export var enemy_3 : PackedScene
@export var enemy_4 : PackedScene
@export var enemy_5 : PackedScene
@export var enemy_6 : PackedScene
@export var enemy_7 : PackedScene
@export var enemyboss : PackedScene

const SCORE_TO_UNLOCK = 500
const SCORE_TO_UNLOCK_3 = 1000
const SCORE_TO_BOSS = 1500

var boss_defeated = false
var level_completed = false
var boss_appeared = false

func _ready() -> void:
	GLOBAL.credits = 3
	GLOBAL.nivel_actual = "res://Escenas/nivel_5.tscn"
	$Settings/MusicaNormal.play()

func _process(delta) -> void:
	parallax_bg(delta)

	$PathSpawn/PathFollow.set_progress(
		$PathSpawn/PathFollow.get_progress() + 70 * delta
	)

	if GLOBAL.score >= SCORE_TO_BOSS and not boss_appeared:
		boss_appeared = true
		$Settings/Timer.stop()

		# Cambiar la música al aparecer el jefe
		$Settings/MusicaNormal.stop()
		$MusicaBoss.play()

		if enemyboss != null:
			var boss_instance = enemyboss.instantiate()
			boss_instance.global_position = Vector2(183, 80)
			add_child(boss_instance)

	if boss_defeated and not level_completed:
		level_completed = true
		get_tree().call_deferred(
			"change_scene_to_file",
			"res://Escenas/final.tscn"
		)
		return

func boss_derrotado() -> void:
	boss_defeated = true

func parallax_bg(delta_time) -> void:
	$Fondo/Back.scroll_base_offset -= Vector2(1, 0) * 8 * delta_time
	$Fondo/Edificios.scroll_base_offset -= Vector2(1, 0) * 16 * delta_time
	$Fondo/Escritorios.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time
	$Fondo/Ventanales.scroll_base_offset -= Vector2(1, 0) * 24 * delta_time

func _on_timer_timeout():
	if boss_appeared or GLOBAL.score >= SCORE_TO_BOSS:
		return

	var enemy_scene = enemy

	if GLOBAL.score >= SCORE_TO_UNLOCK_3:
		var random_enemy = randi_range(0, 6)

		match random_enemy:
			0: enemy_scene = enemy
			1: enemy_scene = enemy_2
			2: enemy_scene = enemy_3
			3: enemy_scene = enemy_4
			4: enemy_scene = enemy_5
			5: enemy_scene = enemy_6
			6: enemy_scene = enemy_7

	elif GLOBAL.score >= SCORE_TO_UNLOCK:
		if randi_range(0, 1) == 1:
			enemy_scene = enemy_6

	if enemy_scene == null:
		return

	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = $PathSpawn/PathFollow.global_position
	add_child(enemy_instance)

func _on_musica_boss_finished() -> void:
	# Regresar a la música normal
	$Settings/MusicaNormal.play()

func _on_musica_normal_finished() -> void:
	pass
