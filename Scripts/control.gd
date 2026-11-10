
extends CharacterBody2D
class_name Player

@export var shot: PackedScene
@onready var screensize = get_viewport_rect().size

const SPEED = 80

func _ready() -> void:
	cambiar_nave()

func cambiar_nave() -> void:
	var textura = load(GLOBAL.nave_seleccionada) as Texture2D

	if textura == null:
		print("No se pudo cargar la imagen de la nave")
		return

	var frames = $Spaceship.sprite_frames

	for animacion in frames.get_animation_names():
		for i in range(frames.get_frame_count(animacion)):
			frames.set_frame(animacion, i, textura)

func _process(_delta):
	anim_ctrl()
	motion_ctrl()

func _input(event):
	if event.is_action_pressed("ui_accept") or Input.is_action_pressed("Disparar"):
		shoot_ctrl()

func anim_ctrl() -> void:
	if GLOBAL.get_axis().y > 0:
		$Spaceship.animation = "up"
	elif GLOBAL.get_axis().y < 0:
		$Spaceship.animation = "down"
	else:
		$Spaceship.animation = "idle"

func motion_ctrl() -> void:
	velocity.x = GLOBAL.get_axis().x * SPEED
	velocity.y = GLOBAL.get_axis().y * -SPEED
	move_and_slide()

func shoot_ctrl() -> void:
	$Flash.play("flash")
	$settings/AudioStreamPlayer.play()

	var shot_instance = shot.instantiate()
	shot_instance.global_position = $settings/ShootSpawn.global_position

	get_tree().current_scene.add_child(shot_instance)
