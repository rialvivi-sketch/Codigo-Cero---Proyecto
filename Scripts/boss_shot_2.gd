extends Area2D

@export var speed := 280.0

var direction := Vector2.LEFT

func set_direction(target_position: Vector2) -> void:
	direction = global_position.direction_to(target_position)

func set_direction_vector(new_direction: Vector2) -> void:
	direction = new_direction.normalized()

func _process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GLOBAL.credits -= 1
		body.queue_free()
		queue_free()

		if GLOBAL.credits <= 0:
			get_tree().call_deferred(
				"change_scene_to_file",
				"res://Escenas/game_over.tscn"
			)
		else:
			GLOBAL.respawn_player()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
