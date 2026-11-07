extends Control

func _on_boton_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/nivel1.tscn")
	
func _on_boton_naves_pressed() -> void:
	get_tree().change_scene_to_file("res://naves.tscn")

func _on_boton_salir_pressed() -> void:
	get_tree().quit()
