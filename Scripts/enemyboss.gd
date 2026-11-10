extends Node2D

@export var boss_shot: PackedScene

const SPEED = 100
const HEALTH = 50
const AMPLITUDE = 70.0
const FREQUENCY = 2.0
const SHOOT_INTERVAL = 1.5


var current_health = HEALTH
var explosion = false

var tiempo = 0.0
var tiempo_disparo = 0.0
var posicion_inicial = Vector2.ZERO

func _ready() -> void:
	$Explosion.stop()
	$Explosion.visible = false
	if not $Explosion.animation_finished.is_connected(_on_explosion_animation_finished):
		$Explosion.animation_finished.connect(_on_explosion_animation_finished)
	
	posicion_inicial = global_position


func _process(delta: float) -> void:
	if explosion:
		return

	tiempo += delta

	global_position.x = posicion_inicial.x + sin(tiempo) * 70
	global_position.y = posicion_inicial.y + sin(tiempo * FREQUENCY) * AMPLITUDE

	tiempo_disparo += delta

	if tiempo_disparo >= SHOOT_INTERVAL:
		tiempo_disparo = 0.0
		disparar()


func disparar() -> void:
	if boss_shot == null:
		return

	var player = get_tree().get_first_node_in_group("Player")

	if player == null:
		return

	var shot_instance = boss_shot.instantiate()
	get_tree().current_scene.add_child(shot_instance)

	shot_instance.global_position = $ShootPoint.global_position
	shot_instance.set_direction(player.global_position)


func take_damage() -> void:
	if explosion:
		return

	current_health -= 1

	if current_health <= 0:
		explosion_ctrl()
		GLOBAL.score += 200
	
	
func _on_explosion_animation_finished() -> void:
	if explosion:
		var level = get_tree().current_scene

		if level.has_method("boss_derrotado"):
			level.boss_derrotado()

		queue_free()


func explosion_ctrl() -> void:
	if explosion:
		return

	explosion = true

	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$Area2D/VisibleOnScreenNotifier2D.queue_free()

	$Explosion.visible = true
	$Explosion.play("Explosion")
	$Explosion/Audio.play()


func _on_enemyboss_body_entered(body: Node2D) -> void:
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

func _on_audio_finished() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
