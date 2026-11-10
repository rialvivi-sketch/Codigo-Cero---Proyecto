extends CharacterBody2D
class_name Player

@export var shot : PackedScene
@onready var screensize  = get_viewport_rect().size

const SPEED = 80

func _process (_delta):
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
