extends Node2D


func _on_resart_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
	
func _on_exit_pressed() -> void:
	get_tree().quit()
