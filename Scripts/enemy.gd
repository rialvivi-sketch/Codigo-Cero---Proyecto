
extends Node2D

const SPEED = 60
const HEALTH = 1

var current_health = HEALTH
var explosion = false

func _ready() -> void:
	$Explosion.stop()

func _process(delta) -> void:
	if not explosion:
		global_position.x -= SPEED * delta

func take_damage() -> void:
	if explosion:
		return

	current_health -= 1

	if current_health <= 0:
		explosion_ctrl()
		GLOBAL.score += 100

func explosion_ctrl() -> void:
	if explosion:
		return

	explosion = true
	$Area2D.queue_free()
	$Explosion.play("Explosion")
	$Explosion/Audio.play()

func _on_area_2d_body_entered(body):
	if body is Player:
		explosion_ctrl()
		GLOBAL.credits -= 1

		if GLOBAL.credits <= 0:
			get_tree().call_deferred("change_scene_to_file", "res://Escenas/game_over.tscn")
		else:
			var level = get_tree().get_first_node_in_group("Level")
			body.queue_free()

			if level != null:
				level.call_deferred("respawn_player")

func _on_audio_finished() -> void:
	queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
