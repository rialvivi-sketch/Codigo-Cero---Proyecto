extends Control


var nave1_dir: String = "res://Imagenes/naves/CimaNave.png"
var nave2_dir: String = "res://Imagenes/naves/CimaNaveRosita.png"

func _on_boton_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/naves.tscn")
	
func _on_boton_naves_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/naves.tscn")

func _on_boton_salir_pressed() -> void:
	get_tree().quit()
