extends Node2D

const SPEED = 110
const HEALTH = 3

var current_health = HEALTH
var explosion = false

func _ready() -> void:
	$Explosion.stop()
	$Explosion.visible = false

func _process(delta) -> void:
	if not explosion:
		global_position.x -= SPEED * delta

func take_damage() -> void:
	if explosion:
		return

	current_health -= 1

	if current_health <= 0:
		explosion_ctrl()
		GLOBAL.score += 500

func explosion_ctrl() -> void:
	if explosion:
		return

	explosion = true
	$enemy3.queue_free()
	$Explosion.visible = true
	$Explosion.play("Explosion")
	$Explosion/Audio.play()

				
func _on_audio_finished() -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_enemy_3_body_entered(body: Node2D) -> void:
	if body is Player:
		GLOBAL.credits -= 1

		if GLOBAL.credits <= 0:
			get_tree().call_deferred(
				"change_scene_to_file",
				"res://Escenas/game_over.tscn"
			)
		else:
			body.queue_free()
			GLOBAL.respawn_player()


func _on_enemy_3_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		take_damage()
		area.queue_free()
