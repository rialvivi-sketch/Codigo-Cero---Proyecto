extends Node2D

const SPEED = 100
const HEALTH = 3

var current_health = HEALTH
var explosion = false

func _ready() -> void:
	$Explosion.stop()
	$Explosion.visible = false

func _process(_delta) -> void:
	if not explosion:
		global_position.x 

func take_damage() -> void:
	if explosion:
		return

	current_health -= 1

	if current_health <= 0:
		explosion_ctrl()
		GLOBAL.score += 200

func explosion_ctrl() -> void:
	if explosion:
		return

	explosion = true
	$enemyboss.queue_free()
	$Explosion.visible = true
	$Explosion.play("Explosion")
	$Explosion/Audio.play()

func _on_enemyboss_body_entered(body: Node2D) -> void:
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

func _on_enemyboss_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		take_damage()
		area.queue_free()

func _on_audio_finished() -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
