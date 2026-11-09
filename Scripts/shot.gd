
extends Area2D

const SPEED = 296

func _process(delta):
	global_position.x += SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		var enemy = area.get_parent()

		if enemy.has_method("take_damage"):
			enemy.take_damage()

		queue_free()
