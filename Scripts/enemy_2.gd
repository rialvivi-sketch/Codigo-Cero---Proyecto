extends Node2D

const SPEED = 60

@onready var explosion  : bool  = false

func _process(delta) -> void:
	match explosion:
		false: global_position.x -= SPEED * delta
		
func explosion_ctrl() -> void:
	explosion = true
	$enemy2.queue_free()
	$Explosion.visible = true
	$Explosion.play("Explosion")
	$Explosion/Audio.play()
	
func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()


	

func _on_audio_finished() -> void:
	queue_free()
	
	if GLOBAL.credits <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func _ready() -> void:
	$Explosion.stop()
	$Explosion.visible = false

func _on_enemy_2_body_entered(body: Node2D) -> void:
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


func _on_enemy_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("Shot"):
		explosion_ctrl()
		GLOBAL.score += 100
		area.queue_free()
