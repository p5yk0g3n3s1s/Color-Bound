extends KinematicBody2D

func _physics_process(delta):
	player_movement()

func player_movement():
	var velocity = Vector2.ZERO
	position.x = 16
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	move_and_slide(velocity * GLOBALS.player_speed)

func hit(ball_color):
	if GLOBALS.sound_fx: $"../BounceAudio".play()
	var particle_material = $"../Ball/Particles2D".process_material
	GLOBALS.lr_dir = 1
	particle_material.gravity.x = -1000

	# Influence the direction
	if Input.is_action_pressed("ui_down"):
		GLOBALS.ud_dir = -1
		particle_material.gravity.y = -1000
	if Input.is_action_pressed("ui_up"):
		GLOBALS.ud_dir = 1
		particle_material.gravity.y = 1000

	# Increase level
	GLOBALS.level += 1
	GLOBALS.ball_speed += GLOBALS.speed_increase
	$"../LevelLabel".text = 'Level: ' + str(GLOBALS.level)
	$"../MusicAudio".pitch_scale += 0.001

	# New Ball Color
	randomize()
	var color = Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1))
	$"../Ball/BallRect".color = color
	particle_material.color = color
