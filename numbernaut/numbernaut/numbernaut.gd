extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var camera = $Camera2D

var gravity = 120
var max_gravity = 100
var speed = 90.0
var acceleration = 8.0
var number = 5
var jump_force = 60
var hurt_force = 30

var is_game_over = false

func _physics_process(delta: float) -> void:
	#gravity
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, -max_gravity, max_gravity)
	max_gravity += delta * 2
	
	#movement
	var x_input = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	velocity.x = lerp(velocity.x, x_input * speed, acceleration * delta)
	
	global_position.x = clamp(global_position.x, 0, 100)
	
	#spritedir
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	
	#stretch
	sprite.scale = lerp(sprite.scale, Vector2(1, 1), 5 * delta)
	
	#number
	sprite.frame = number
	
	if number == 0 && !is_game_over:
		is_game_over = true
		game_over()
	
	move_and_slide()
	
	#camera
	await get_tree().create_timer(1.0).timeout
	camera.offset.y = lerp(camera.offset.y, 20.0, delta)

func jump():
	velocity.y = -jump_force
	
	if max_gravity > 105:
		max_gravity -= 2
	
	if number < 5:
		number += 1
	
	sprite.scale = Vector2(1.4, 0.6)
	
	Sfxlibrary.play("jump")

func hurt():
	velocity.y = -hurt_force
	
	if max_gravity > 105:
		max_gravity -= 3
	
	if number > 0:
		number -= 1
	
	Sfxlibrary.play("hurt")

func game_over():
	await get_tree().create_timer(0.25).timeout
	set_physics_process(false)
	await get_tree().create_timer(0.25).timeout
	Sfxlibrary.play("over")
	Sfxlibrary.music.stop()
	await get_tree().create_timer(0.25).timeout
	get_tree().reload_current_scene()
	Sfxlibrary.music.play()
