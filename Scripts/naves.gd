extends Control

var nave1_dir: String = "res://Imagenes/naves/CimaNave.png"
var nave2_dir: String = "res://Imagenes/naves/CimaNaveRosita.png"

func go_to_scene():
	get_tree().change_scene_to_file("res://Escenas/nivel1.tscn")
	
func _on_nave_1_pressed() -> void:
	GLOBAL.nave_seleccionada = nave1_dir
	go_to_scene()

func _on_nave_2_pressed() -> void:
	GLOBAL.nave_seleccionada = nave2_dir
	go_to_scene()
