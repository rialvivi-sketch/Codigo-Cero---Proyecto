extends Control

func _on_resart_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.nivel_actual)
	
func _on_exit_pressed() -> void:
	get_tree().quit()
