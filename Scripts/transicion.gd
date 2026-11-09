
extends CanvasLayer

var cambiando := false

func _ready() -> void:
	layer = 100
	$Fondo.visible = false
	$Fondo.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Fondo/TextoNivel.visible = false


func mostrar_nivel(numero: int, siguiente_escena: String) -> void:
	if cambiando:
		return

	cambiando = true
	get_tree().paused = true

	$Fondo.visible = true
	$Fondo.color = Color(0, 0, 0, 0)
	$Fondo/TextoNivel.visible = true
	$Fondo/TextoNivel.text = "LEVEL " + str(numero)
	$SonidoNivel.play()
	$Fondo/TextoNivel.modulate.a = 0.0

	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($Fondo, "color:a", 0.85, 0.4)
	await tween.finished

	var tween_texto = create_tween()
	tween_texto.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween_texto.tween_property($Fondo/TextoNivel, "modulate:a", 1.0, 0.5)
	await tween_texto.finished

	await get_tree().create_timer(1.5, true, false, true).timeout

	var error = get_tree().change_scene_to_file(siguiente_escena)

	if error != OK:
		get_tree().paused = false
		cambiando = false
		return

	await get_tree().scene_changed

	var salida = create_tween()
	salida.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	salida.set_parallel(true)
	salida.tween_property($Fondo, "color:a", 0.0, 0.5)
	salida.tween_property($Fondo/TextoNivel, "modulate:a", 0.0, 0.5)
	await salida.finished

	$Fondo.visible = false
	$Fondo/TextoNivel.visible = false

	get_tree().paused = false
	cambiando = false
