extends Control


func _on_resart_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/nivel_2.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
